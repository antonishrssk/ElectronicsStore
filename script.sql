USE [master]
GO
/****** Object:  Database [ElectronicsStore]    Script Date: 12.02.2025 8:27:46 ******/
CREATE DATABASE [ElectronicsStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ElectronicsStore', FILENAME = N'C:\Users\Professional\ElectronicsStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ElectronicsStore_log', FILENAME = N'C:\Users\Professional\ElectronicsStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ElectronicsStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ElectronicsStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ElectronicsStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ElectronicsStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ElectronicsStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ElectronicsStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ElectronicsStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [ElectronicsStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ElectronicsStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ElectronicsStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ElectronicsStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ElectronicsStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ElectronicsStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ElectronicsStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ElectronicsStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ElectronicsStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ElectronicsStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ElectronicsStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ElectronicsStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ElectronicsStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ElectronicsStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ElectronicsStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ElectronicsStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ElectronicsStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ElectronicsStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ElectronicsStore] SET  MULTI_USER 
GO
ALTER DATABASE [ElectronicsStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ElectronicsStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ElectronicsStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ElectronicsStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ElectronicsStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ElectronicsStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ElectronicsStore] SET QUERY_STORE = OFF
GO
USE [ElectronicsStore]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[CategoryId] [smallint] NOT NULL,
	[Price] [money] NOT NULL,
	[StockQuantity] [int] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductsInfo]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductsInfo]
AS
SELECT        dbo.Product.Id, dbo.Product.Name, dbo.Product.Description, dbo.Category.Name AS Category, dbo.Product.Price, dbo.Product.StockQuantity
FROM            dbo.Category INNER JOIN
                         dbo.Product ON dbo.Category.Id = dbo.Product.CategoryId
GO
/****** Object:  Table [dbo].[User]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](70) NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Password] [nvarchar](256) NOT NULL,
	[RoleId] [tinyint] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[ProductId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShoppingCartContent]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ShoppingCartContent]
AS
SELECT        dbo.Product.Id AS ProductId, dbo.Product.Name AS ProductName, dbo.Product.Price, dbo.ShoppingCart.Quantity, dbo.[User].Id AS UserId
FROM            dbo.Product INNER JOIN
                         dbo.ShoppingCart ON dbo.Product.Id = dbo.ShoppingCart.ProductId INNER JOIN
                         dbo.[User] ON dbo.ShoppingCart.UserId = dbo.[User].Id
GO
/****** Object:  Table [dbo].[Order]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderContent]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderContent](
	[OrderId] [bigint] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderedProducts] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name]) VALUES (1, N'Смартфоны')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (2, N'Умные часы')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (3, N'Настольные компьютеры')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (4, N'Ноутбуки')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (5, N'Мониторы')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (6, N'Клавиатуры и мыши')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (7, N'Телевизоры')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (8, N'Наушники')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (9, N'Bluetooth-колонки')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (10, N'Фотоаппараты')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (11, N'Принтеры')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (12, N'Игровые консоли')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Id], [UserId], [OrderDate]) VALUES (1, 5, CAST(N'2025-02-12T01:31:48.490' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderContent] ([OrderId], [ProductId], [Quantity]) VALUES (1, 5, 6)
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (1, N'iPhone 15 Pro Max', N'Смартфон Apple iPhone 15 Pro Max выкован из титана – прочного и легкого материала, из которого изготовлены его боковые грани. Чип A17 Pro гарантирует невероятную производительность устройства. iPhone 15 Pro Max обладает самым мощным оптическим зумом в истории iPhone.', 1, 119990.0000, 14)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (2, N'Samsung Galaxy S23 Ultra', N'Смартфон Samsung Galaxy S23 Ultra выделяется прямоугольным корпусом с защитой класса IP68 и изогнутой передней панелью. Экран 6.8 дюйма Dynamic AMOLED 2X с любого положения отображает четкую, яркую и красочную картинку. Для продуктивной работы и творчества в модели реализована поддержка фирменного стилуса. Камеры 200+10+12+10 Мп и 12 Мп позволяют создавать реалистичные снимки.', 1, 99990.0000, 61)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (3, N'Xiaomi Redmi Note 12', N'Смартфон Xiaomi Redmi Note 12 в голубом цвете корпуса стал обладателем аккумулятора повышенной емкости 5000 мАч. Модель способна длительное время работать без подзарядки, обеспечивая до 31 часа вызовов, 21 часа воспроизведения видео и 9 часов игр. Тройная камера 50+8+2 Мп позволит запечатлеть мир с любого ракурса, чтобы на память о лучших моментах жизни у вас остались цифровые снимки. На боковой панели расположился сканер отпечатка пальца, отвечающий за конфиденциальность хранящихся на устройстве данных и их недоступность посторонним лицам.', 1, 24990.0000, 246)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (4, N'Google Pixel 8 Pro', N'Смартфон Google Pixel 8 Pro получил дисплей с диагональю 6.7 дюймов. Разрешение матрицы - 1344x2992 пикселя. Заявлена пиковая яркость в 2400 нит и динамическая частота развертки, изменяющаяся в диапазоне от 1 до 120 Гц. В смартфоне используется фронтальная камера на 10.5 Мп с апертурой f/2.2. В смартфон установили 50-мегапиксельный главный сенсор с апертурой f/1.68 и два дополнительных - 48-мегапиксельный телефото-датчик (f/2.8) и 48-мегапиксельную сверхширокоугольную камеру (f/1.95). Благодаря обновленному телефото-датчику Pixel 8 Pro поддерживает 5-кратный оптический зум. Камеры поддерживают запись видео в разрешении 4K с частотой 60 fps.', 1, 89990.0000, 64)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (5, N'OnePlus 11', N'Смартфон OnePlus 11 выполнен в тонком стеклянном корпусе зеленого цвета. Одно из преимуществ модели – экран 6.7 дюйма AMOLED, способный впечатлять детализированной картинкой с яркими и насыщенными оттенками. Отзывчивая работа системы при запуске приложений и выполнении других задач обеспечивается процессором Snapdragon 8 Gen 2, а 16 ГБ оперативной памяти гарантируют быстродействие.', 1, 69990.0000, 180)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (6, N'Huawei P60 Pro', N'Смартфон HUAWEI P60 Pro 512 ГБ выполнен в белом стеклянном корпусе и оснащен изогнутым безрамочным экраном. Панель OLED 6.67 дюйма обеспечивает детализированное изображение с высокой яркостью и насыщенностью оттенков. Защищенная конструкция IP68 гарантирует устойчивость к воздействию пыли и влаги, а стекло Kunlun Glass уберегает экран от царапин и других дефектов.', 1, 79990.0000, 109)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (7, N'Apple Watch Series 9', N'Смарт-часы Apple Watch Series 9 45mm информируют пользователя о сердечном ритме, пройденном расстоянии, температуре тела. Данные транслируются на квадратный дисплей с особым датчиком. Он анализирует внешнюю освещенность и вносит коррективы в показатель яркости. Предусмотрена возможность управления жестами.', 2, 34990.0000, 244)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (8, N'Samsung Galaxy Watch 6', N'Смарт-часы Samsung Galaxy Watch6 40mm оборудованы сенсорным Super AMOLED-дисплеем диагональю 1.3 дюйма. Он отображает температуру тела, пульс, количество пройденных шагов, данные о качестве сна. С использованием женского календаря можно контролировать цикл и симптомы. Защита по стандарту IP68 делает алюминиевый корпус устойчивым к влаге.', 2, 29990.0000, 189)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (9, N'Xiaomi Mi Band 8', N'Фитнес-браслет Xiaomi Smart Band 8 определяет пройденное расстояние, содержание кислорода в крови, пульс, уровень стресса. Информация отображается на сенсорном 1.62-дюймовом дисплее. Предусмотрена возможность выбора подходящей среди 150 предустановленных тренировок. Во время фиксации на запястье используется регулируемый силиконовый ремешок.', 2, 3990.0000, 160)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (10, N'Apple iMac 24" (M3)', N'Совершенный компьютер «всё в одном», теперь оснащённый чипом M3. Потрясающий 24-дюймовый дисплей и культовый дизайн, который украсит любое пространство.', 3, 119990.0000, 8)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (11, N'Dell XPS Desktop', N'Модель Dell XPS 8500 основывается на четырех ядерном процессоре Intel Core i7. Устройство позволяет проводить многочисленные вычислительные операции, гарантирует высокий уровень производительности и безопасности.', 3, 79990.0000, 16)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (13, N'HP Pavilion Gaming Desktop', N'ПК HP Pavilion Gaming TG01-1022ur [304N7EA] представляет собой системный блок, оснащенный необходимыми элементами для загрузки энергоемких шутеров, симуляторов и других игр. Модель имеет дискретную видеокарту процессор Intel Core i5 10400F с тактовой частотой 2900 МГц и 6 ядрами. Устройство обеспечивает плавную передачу высококачественных изображений в динамичных сценах.', 3, 59990.0000, 150)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (14, N'Lenovo Legion Tower 5', N'ПК Lenovo Legion T5 26AMR5 [90RC01N3RU] получает черный среднеразмерный корпус и производительные компоненты – центральный процессор AMD Ryzen 5 5600G и оперативную память стандарта DDR4 емкостью 16 ГБ. В системном блоке, рассчитанной на запуск ресурсоемкого софта, использован дискретный видеопроцессор GeForce RTX 3060. Видеокарта с емкостью видеопамяти 12 ГБ отвечает за операции с графическим контентом.', 3, 69990.0000, 153)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (15, N'MacBook Air 15" (M2)', N'Большой MacBook Air построен на мощной, и в то же время энергоэффективной однокристальной системе M2 с 8-ядерным CPU и 10-ядерным GPU. За счёт этого обеспечивается и приличная автономность (18 часов). Ноутбук выполнен в ультратонком металлическом корпусе. Вы сможете брать его с собой повсюду и эффективно справляться с различными задачами. На экране IPS 15.3 дюймов отображается детализированная картинка с реалистичной передачей цветовой палитры.', 4, 129990.0000, 76)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (16, N'Dell XPS 13 Plus', N'Ноутбук Dell XPS 13 9345 на базе процессора Snapdragon идеально подходит для современных пользователей, которые ценят мощность и портативность. Это устройство сочетает в себе стильный дизайн, высокую производительность и продолжительное время автономной работы, что делает его отличным выбором для работы, учёбы и развлечений.', 4, 119990.0000, 1)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (17, N'ASUS ROG Zephyrus G14', N'Ноутбук ASUS ROG Zephyrus G14 GA403UI-QS045W выполнен в корпусе из алюминиевого сплава. Крышка украшена диагональной полосой с подсветкой Slash Lighting. Ее анимационные эффекты настраиваются по предпочтениям пользователя. За высокую вычислительную мощность в программах с разными графическими требованиями отвечают процессор AMD Ryzen 9 8945HS и видеокарта GeForce RTX 4070. Работа без задержек обеспечивается 32 ГБ оперативной памяти и накопителем M.2 PCIe объемом 1000 ГБ. Комплексная система охлаждения с 3 вентиляторами и тепловыми трубками поддерживает низкую температуру внутренних компонентов.', 4, 99990.0000, 181)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (19, N'Lenovo ThinkPad X1 Carbon', N'Ультрабук Lenovo ThinkPad X1 Carbon G11 черного цвета получил экран диагональю 14 дюймов с разрешением 1920×1200 пикселей и IPS-матрицей, которая обеспечивает широкие углы обзора и позволяет видеть изображение на мониторе без искажений даже со стороны или сверху. Дисплей устройства имеет антибликовые покрытие, оно гасит блики и защищает дисплей от засвечивания при нахождении вблизи ярких источников света. ПК оснащен модулем оперативной памяти последнего поколения LPDDR5 на 32 ГБ, расширенный объем оперативки гарантирует молниеносный отклик на команды, позволяет одновременно работать в нескольких приложениях.', 4, 109990.0000, 90)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (20, N'Acer Swift 3', N'Ноутбук Acer Swift 3 SF314-59-393K выполнен в прочном алюминиевом корпусе. Наряду с элегантным исполнением и компактными размерами он выделяется весьма высокой производительностью, позволяя продуктивно работать и увлекательно проводить досуг. Аппаратная платформа представлена процессором Intel Core i3, 8 ГБ оперативной памяти и накопителем SSD 256 ГБ. Работает портативный компьютер под управлением Windows 10 Home.', 4, 59990.0000, 23)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (21, N'Samsung Odyssey G9', N'Монитор Samsung Odyssey OLED G9 G93SD S49DG932SI оснащен OLED-матрицей с поддержкой технологии квантовых точек. Это решение обеспечивает больше оттенков и выше контрастность, чему у других дисплеев. Диагональ экрана составляет 49 дюймов.', 5, 119990.0000, 197)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (22, N'LG UltraFine 4K 27"', N'Монитор LG UltraFine 27US500-W в тонком белом корпусе обладает дисплеем с увеличенной рабочей площадью и диагональю 27 дюймов (69 см). Модель установлена на изящную подставку. Разрешение устройства, основанного на матрице IPS, составляет 3840х2160 пикселей и сочетается с динамической контрастностью Mega DCR. Это указывает на потрясающее качество транслируемого изображения вкупе с плавным и быстрым обновлением картинки.', 5, 69990.0000, 237)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (23, N'Dell UltraSharp U4323QE', N'Монитор Dell UltraSharp U4323QE с диагональю экрана 43 дюйма оснащен IPS матрицей и имеет частоту обновления 76 Гц.
Эргономичная подставка позволяет регулировать наклон и высоту экрана, а также поворачивать его.', 5, 79990.0000, 229)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (24, N'Acer Predator X34', N'Монитор Acer Predator X34Xbmiiphuzx создан для самых требовательных поклонников компьютерных игр и оборудован широкоформатным дисплеем с практически незаметной рамкой, который способствует максимальному погружению в мир увлекательных игр и завораживающей графики. В основе экрана содержится изогнутая матрица OLED 34 дюйма с разрешающей способностью 3440x1440 пикселей и радиусом кривизны 800R. Отклик 0,01 мс и частота до 240 Гц помогают избежать размытия динамичных кадров.', 5, 99990.0000, 190)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (25, N'BenQ PD3205U', N'Монитор PD3205U с 99% цветового охвата sRGB и Rec.709 достигает удивительной точности цвета благодаря Delta E ≤ 3. Вы легко сможете загружать и отображать контент импортированный из различных источников. Совместим с форматами HDR10, что позволяет повысить эффективность работы, просматривая HDR-контент еще на этапе редактирования. Специальные режимы отображения помогут показать ваши проекты с наилучшей стороны. Новый KVM-переключатель автоматически синхронизируется с источниками ввода. Переключайте источники сигнала монитора одним нажатием клавиши Hotkey Puck G2, для экономии места и повышения эффективности работы.', 5, 109990.0000, 13)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (26, N'Razer BlackWidow V4 Pro', N'Механическая клавиатура Razer BlackWidow V4 Pro оснащена RGB подсветкой по периметру клавиатуры и по области кейкапа. Для расширения функционала добавлены: многофункциональный ролик, 4 медиа-кнопки, цифровое колесико управления, 5 макро-клавиш слева на клавиатуре и 3 боковые кнопки на левой стороне клавиатуры.', 6, 14990.0000, 234)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (27, N'Corsair K95 RGB Platinum', N'Клавиатура Corsair K95 RGB Platinum – модель от известного производителя комплектующих и аксессуаров для ПК. Она подойдет для игр, печати, работы, универсальна в использовании. Выполнено изделие в приятном черном цвете.', 6, 19990.0000, 112)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (28, N'Logitech G502 Hero', N'Мышь проводная Logitech G502 HERO – игровой манипулятор с 11 кнопками в конструкции. Устройство располагает встроенной памятью, в которую можно сохранить настройки разрешения, конфигурацию программируемых кнопок и параметры RGB-подсветки. Оптический светодиодный сенсор HERO 16K обеспечивает точное позиционирование курсора на экране благодаря настраиваемому режиму работы в диапазоне от 200 до 16000 dpi. Проводная мышь Logitech G502 HERO предусматривает систему регулировки веса для комфортного использования любым пользователем.', 6, 5990.0000, 7)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (29, N'SteelSeries Rival 5', N'Мышь проводная SteelSeries Rival 5 [62551] выполнена на основе пластика с матовым покрытием, поверхность которого устойчива к появлению загрязнений и оседанию пыли. Кабель длиной 2 м защищен прочной тканевой оплеткой. Она предупреждает скручивание и образование заломов. RGB-подсветка делает комфортнее использование аксессуара с наступлением сумерек.', 6, 6990.0000, 239)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (30, N'Samsung LED QE75QN900DUXRU', N'Телевизор LED Samsung QE75QN900DUXRU выполнен в тонком корпусе черного цвета с практически незаметной рамкой и дополнен устойчивой серой подставкой.', 7, 149990.0000, 245)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (31, N'LG OLED65C3RLA', N'Телевизор OLED LG OLED65C3RLA привлекает внимание тонкой серой рамкой с устойчивой съемной подставкой для установки на тумбу или стену. Экран 65” с 4K-разрешением радует красочным, насыщенным и детальным изображением. Интеллектуальный процессор α9 4K Gen6 запускает алгоритмы усиления яркости и контроля света для создания более реалистичной картинки. Мощные динамики на 40 Вт с сабвуфером и 5 технологиями делают звук объемным и четким на любой громкости.
LG OLED65C3RLA дополнен специальным игровым режимом с высокой контрастностью и насыщенностью. Компьютерная графика эффектно выглядит, динамичные сцены не тормозят, управление персонажем сохраняет плавность и точность. Система webOS обладает удобным меню настроек, Smart TV и других функций. Вы можете задействовать голосового помощника Алису, управлять устройством через мобильное приложение LG ThinQ.', 7, 129990.0000, 13)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (32, N'Sony Bravia XR A80L', N'Sony A80L размером 65 дюймов, то есть XR-65A80L, привнесет кинотеатр в ваш дом с яркими и красивыми деталями. На OLED-телевизоре Sony BRAVIA A80L все невероятно реалистично, как в последних блокбастерах Голливуда, так и в классике. Так что вы действительно можете перенести кинотеатр в свой дом! Стильный дизайн, OLED с невероятной контрастностью, панель с частотой 120 Гц и операционная система Google TV создают непревзойденное целое.', 7, 139990.0000, 212)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (33, N'TCL 6-Series Roku TV', N'Телевизор TCL 43V6B 43" LED UHD Google TV - это современный телевизор, который сочетает в себе высокое качество изображения, мощные функциональные возможности и простоту использования. С его 43-дюймовым LED-дисплеем вы сможете насладиться четким и ярким изображением с разрешением Ultra HD.
Он оснащен функцией Smart TV, что позволяет вам пользоваться множеством приложений, стриминговых сервисов и онлайн контента прямо на своем телевизоре. Благодаря андроид ТВ, вы легко найдете и установите любимые приложения из Google Play Store.
Телевизор TCL 43V6B 43" LED UHD Google TV поддерживает технологию Android TV, что значит, что вы сможете управлять им голосом, используя Google Assistant. Просто скажите, что вы хотите посмотреть или сделать, и телевизор выполнит вашу команду.
С разрешением Ultra HD, каждая деталь на экране будет выглядеть четко и реалистично. Он также имеет широкий угол обзора, что позволяет вам наслаждаться качественным изображением из любого места в комнате.', 7, 79990.0000, 88)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (34, N'Philips Ambilight OLED+935', N'Телевизоры Ambilight — единственные телевизоры со встроенными светодиодными лампами на задней панели, которые реагируют на то, что вы смотрите, погружая вас в ореол красочного света. Это меняет все: ваш телевизор кажется больше, и вы глубже погружаетесь в любимые виды спорта, фильмы, музыку и игры.', 7, 159990.0000, 170)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (35, N'Sony WH-1000XM5', N'Благодаря 2 процессорам, управляющим 8 микрофонами, автоматической оптимизации шумоподавления в зависимости от условий ношения и окружающей среды, а также специальному динамику, наушники Sony WH-1000XM5 с передовой системой шумоподавления дарят незабываемые ощущения от прослушивания и обеспечивают четкость во время разговора.', 8, 29990.0000, 121)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (36, N'Apple AirPods Max', N'Bluetooth гарнитура Apple AirPods Max – модель полноразмерных наушников с элегантным исполнением, эргономичной конструкцией и характеристиками премиального уровня. Динамические драйверы формируют насыщенный реалистичный звук, погружающий в прослушивание музыки. Встроенный микрофон предоставляет возможность общения. Благодаря функции активного шумоподавления блокируются внешние шумы.', 8, 59990.0000, 191)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (37, N'Bose QuietComfort 45', N'Bose QuietComfort 45 – беспроводные полноразмерные наушники с шумоподавлением классического дизайна, с временем работы от аккумулятора 24 часа', 8, 34990.0000, 19)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (38, N'Jabra Elite 85h', N'Bluetooth стереогарнитура Jabra Elite 85h оснащена охватывающими амбушюрами и разработана для беспроводной передачи музыки и общения. Реализованная в ней SmartSound способствует подстраиванию звука под окружение пользователя. Эта система после проведения анализа включает автоматически те параметры звука, которые он ранее установил, систему шумоподавления, а также функцию "HearThrough", позволяющую достичь желательного качества звука.', 8, 19990.0000, 242)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (40, N'JBL Flip 6', N'Портативная колонка JBL Flip 6 позволит получать удовольствие от громкого, чистого и мощного звука. Динамик выходной мощностью 30 Вт в сочетании с сабвуфером передает насыщенный детализированный звук. Для достижения глубоких низких частот в колонке установлены два оптимизированных пассивных радиатора на основе технологии от Harman. Синхронизация с мобильными устройствами осуществляется по беспроводной технологии Bluetooth. Корпус колонки надежно защищен от воздействия влаги и пыли по стандарту IPX7. Энергоемкий аккумулятор емкостью 4800 мА*ч гарантирует продолжительное время автономной работы JBL Flip 6 – до 12 часов.', 9, 7990.0000, 222)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (41, N'Sony SRS-XB43B', N'Портативная колонка Sony SRS-XB43B выпускается в стильном черном цвете в прорезиненном корпусе из пластика с металлическими вставками. Оригинальность дизайна и дополнительный комфорт обеспечивает встроенная подсветка. Звук передается через 4 динамика. Минимальная воспроизводимая частота – 20 Гц, максимальная – 20000 Гц. Интегрированный микрофон позволяет использовать акустическую систему как устройство для громкой связи. Корпус дополнительно защищен от влаги и пыли, степень защищенности – IP67. Благодаря этому показателю устройство легко перенесет погружение в воду на глубину до 1 м на полчаса.', 9, 14990.0000, 144)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (42, N'Bose SoundLink Revolve+', N'Bose SoundLink Revolve+ II – мощная колонка со звуком на 360°, разработанная для чистого насыщенного звучания с внушительным басом. Колонка имеет однородную круговую диаграмму направленности, равномерно распространяя звук высочайшего качества на 360°. Разместите SoundLink Revolve+ II в центре комнаты – и каждый, независимо от расположения, услышит превосходный звук Bose. Система, расположенная у стены, создает мощное живое звучание за счет отраженных волн. А благодаря удобной ручке, колонку удобно взять с собой, куда бы вы ни направлялись!', 9, 24990.0000, 35)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (43, N'Ultimate Ears MEGABOOM 3', N'Портативная колонка Logitech Ultimate Ears Megaboom 3 в виде красного цилиндра оснащена мощной аудиотехнологией с охватом на 360°. Мощная АКБ выдерживает до 20 ч автономной работы, что позволяет брать устройство с собой. Для зарядки батареи требуется всего 2.5 ч, что благодаря кабелю USB можно делать даже в машине.', 9, 19990.0000, 54)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (44, N'Sony Alpha 7 IV', N'Беззеркальная камера Sony Alpha 7 IV Body с технологией искусственного интеллекта обеспечивает высокое качество съемки фотографий и видео. В ней используется полнокадровая матрица 34.1 Мп CMOS, способная с точностью передавать детали и оттенки на изображении. Гибкая ручная настройка параметров предлагает требовательным пользователям широкие возможности для творчества.', 10, 199990.0000, 80)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (45, N'Canon EOS R6 Mark II', N'Беззеркальная камера Canon EOS R6 Mark II создана для фотографов и видеооператоров. Полнокадровая матрица CMOS с разрешением 24.2 Мп обеспечивает реалистичность передачи деталей и цветовой палитры на снимках. Системы автоматической фокусировки и стабилизации обеспечивают получение резких динамичных кадров без искажений. Процессор Digic X гарантирует высокую производительность и скорость.', 10, 219990.0000, 29)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (46, N'Nikon Z6 II', N'Беззеркальная камера Nikon Z6 II Body с полнокадровой матрицей CMOS 24.5 Мп и высокими показателями пропускания света обеспечивает ведение качественной съемки при различных условиях освещенности. Система гибридной фокусировки обеспечивает точный захват необходимого объекта в кадре. Для просмотра отснятого материала в данной модели установлен дисплей 3.15 дюйма с сенсорной панелью и наклонным механизмом.', 10, 179990.0000, 3)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (47, N'Panasonic Lumix GH6', N'Беззеркальная камера Panasonic GH6 Body с матрицей Live MOS 25.21 Мп обеспечивает создание детализированных фотографий и видео в разрешении 4K. Стабилизация изображения со сдвигом матрицы, серийная съемка со скоростью до 75 кадров за секунду, ISO до 25600 и другие настраиваемые параметры предлагают широкие возможности для воплощения творческих идей. В камере установлен сенсорный дисплей 3 дюйма с наклонным механизмом. Для подключения к устройствам предлагаются проводные и беспроводные интерфейсы. Аккумулятор 2200 мА*ч гарантирует длительное время автономности Panasonic GH6 Body.', 10, 169990.0000, 247)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (48, N'HP LaserJet Pro MFP M283fdw', N'МФУ лазерное HP Color LaserJet Pro MFP M283fdw позволяет справляться с задачами по копированию, сканированию и печати документов, а также отправкой факса. Оно обеспечивает производительную цветную и черно-белую печать со скоростью до 21 страниц за минуту. Благодаря лазерной технологии и картриджам с тонером 4 цветов устройство создает четкие и контрастные отпечатки на бумаге, брошюрах, бланках, конвертах, пленке, картоне и других носителях. Соединение с Интернетом возможно по проводному интерфейсу Ethernet (RJ-45) и беспроводной технологии Wi-Fi. Сенсорная панель с дисплеем гарантирует интуитивную настройку параметров работы МФУ HP Color LaserJet Pro MFP M283fdw.', 11, 24990.0000, 242)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (49, N'Epson EcoTank L6290', N'МФУ Epson EcoTank L6290 – многофункциональный помощник для офиса и дома. Данное устройство оснащено функциями печати, копирования и сканирования документов, а также предусматривает отправку факса. Печать на основе пьезоэлектрической струйной технологии обеспечивает формирование на различных бумажных носителях четких и насыщенных отпечатков.', 11, 29990.0000, 8)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (50, N'Canon PIXMA TS5140', N'МФУ Canon Pixma TS5140 -универсальное устройство с функциями печати, сканирования и копирования, со встроенным Wi-Fi-модулем и поддержкой печати из облачных приложений - подойдет тем, кому необходимо печатать дома напрямую со смартфона, компьютера или камеры. Возможность печати документов и фотографии.', 11, 9990.0000, 203)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (51, N'Xerox VersaLink C405DN', N'МФУ лазерное Xerox VersaLink C405DN – отличный выбор для пользователей, которые хотят оснастить высококачественной техникой офис любого типа. Устройство, соответствующее формату A4, осуществляет цветную печать высочайшего качества. Вы сможете использовать бумагу практически любой плотности: поддерживаемая плотность носителей варьируется от 60 до 220 г/м². В качестве расходных материалов используются 4 картриджа (черный и 3 цветных).', 11, 49990.0000, 234)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (54, N'PlayStation 5', N'Благодаря тонкому дизайну PS5 игроки получают мощные игровые технологии, заключенные в элегантную и компактную консоль. Ваши любимые игры всегда готовы и ждут, пока вы начнете играть, благодаря встроенному твердотельному накопителю емкостью 1 ТБ. Максимизируйте свои игровые сессии благодаря практически мгновенной загрузке установленных игр для PS5. Испытайте полное погружение в невероятно реалистичные миры благодаря специальным алгоритмам вычисления световых лучей, с которыми избранные игры PS5 заиграют красками света, тени и отражений.', 12, 69990.0000, 213)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (55, N'Xbox Series X', N'Игровая консоль Microsoft Xbox Series X способна впечатлять минимальным временем загрузки и завораживающими визуальными эффектами при воспроизведении игр с частотой до 120 кадров в секунду. Благодаря процессору AMD Zen 2 с частотой 3.8 ГГц и 16 ГБ оперативной памяти обеспечивается быстродействие системы. Внутреннее хранилище представлено накопителем емкостью 1 ТБ. Коммуникационные возможности Microsoft Xbox Series X реализованы технологией Wi-Fi, тремя портами USB 3.1, видеовыходом HDMI. В комплекте с игровой консолью поставляется фирменный беспроводной контроллер.', 12, 59990.0000, 245)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (56, N'Steam Deck', N'Портативная игровая консоль Steam Deck OLED выполнена в удобном для удержания черном корпусе с сенсорным дисплеем и аналоговыми джойстиками по краям. 7.4-дюймовый экран показывает четкую и красочную картинку в разрешении 1280 х 800 dpi. Кроме разъема для зарядки в корпусе есть слот для карт памяти и универсальный выход для подключения наушников. Заряда аккумулятора хватает на 12 часов активной игры.', 12, 49990.0000, 132)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (57, N'PlayStation VR2', N'Система виртуальной реальности PlayStation VR2 позволяет ощущать эффект полного погружения в любимую игру. Очки обладают общим разрешением 4000x2040 dpi и обзором в 110°. Встроенные датчики помогают системе точно реагировать на любые движения. Благодаря обработке 3D-звука вы четко ощущаете все происходящее в игре на 360°.', 12, 69990.0000, 217)
INSERT [dbo].[Product] ([Id], [Name], [Description], [CategoryId], [Price], [StockQuantity]) VALUES (58, N'Nintendo Switch OLED', N'Игровая консоль Nintendo Switch OLED в стильном гибридном корпусе оснащена дисплеем 7” с разрешением 1280x720 dpi и сенсором яркости. Широкая опора с регулируемым углом наклона делает удобной игру с друзьями через геймпады с беспроводным подключением. Встроенные динамики гарантируют хорошее звучание в ручном и настольном режимах.
Nintendo Switch OLED оснащена док-станцией с портами LAN и HDMI для проводного подключения к Интернету и большому экрану ТВ. 64 ГБ встроенной памяти позволяет сохранять любимые игры и наслаждаться ими в любом месте. Емкая АКБ требует для зарядки около 3 ч, а выдерживает до 9 ч автономной работы.', 12, 14990.0000, 55)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Администратор')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Клиент')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[ShoppingCart] ([ProductId], [UserId], [Quantity]) VALUES (7, 5, 1)
INSERT [dbo].[ShoppingCart] ([ProductId], [UserId], [Quantity]) VALUES (38, 5, 2)
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [LastName], [FirstName], [Patronymic], [Email], [Password], [RoleId]) VALUES (4, N'Иванов', N'Иван', N'Иванович', N'iiivan@mail.ru', N'admin', 1)
INSERT [dbo].[User] ([Id], [LastName], [FirstName], [Patronymic], [Email], [Password], [RoleId]) VALUES (5, N'Корявый', N'Эдуард', N'', N'eduard.k@mail.ru', N'edkor', 2)
INSERT [dbo].[User] ([Id], [LastName], [FirstName], [Patronymic], [Email], [Password], [RoleId]) VALUES (6, N'Бычков', N'Валентин', N'Олегович', N'balentin33@gmail.com', N'real', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[OrderContent]  WITH CHECK ADD  CONSTRAINT [FK_OrderedProducts_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[OrderContent] CHECK CONSTRAINT [FK_OrderedProducts_Orders]
GO
ALTER TABLE [dbo].[OrderContent]  WITH CHECK ADD  CONSTRAINT [FK_OrderedProducts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[OrderContent] CHECK CONSTRAINT [FK_OrderedProducts_Products]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  Trigger [dbo].[NewOrder]    Script Date: 12.02.2025 8:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[NewOrder]
   ON [dbo].[Order]
   AFTER INSERT
AS 
BEGIN
	INSERT INTO OrderContent (OrderId, ProductId, Quantity)
	SELECT inserted.Id, ShoppingCart.ProductId, ShoppingCart.Quantity
	FROM inserted
	JOIN ShoppingCart ON inserted.UserId = ShoppingCart.UserId

	DELETE FROM ShoppingCart
	WHERE UserId IN (SELECT UserId FROM inserted)
END
GO
ALTER TABLE [dbo].[Order] ENABLE TRIGGER [NewOrder]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Category"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductsInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductsInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ShoppingCart"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 119
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 120
               Left = 250
               Bottom = 250
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1380
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ShoppingCartContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ShoppingCartContent'
GO
USE [master]
GO
ALTER DATABASE [ElectronicsStore] SET  READ_WRITE 
GO
