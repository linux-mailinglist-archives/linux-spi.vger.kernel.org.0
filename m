Return-Path: <linux-spi+bounces-10365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BDBAB006
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB25189E8A2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8323BD13;
	Tue, 30 Sep 2025 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="PdTALq4M"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31D238D32;
	Tue, 30 Sep 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199243; cv=fail; b=Osnd4G4KN9SBFesDuRUEpe+S/3DnauGMl5nEm6xtvv4n4D/SbSPKnMYEXvhe5xiZ2bnWj2/VbPAYkxUfDsCPVmlaYlEAcaKXWXrcTTf9Aey/rZ7CtZS6NEh5A+t/s/zVSVgb3gRs1VHo3C1mHi1txm2UES1FeoLvPKdhBgA24VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199243; c=relaxed/simple;
	bh=1qKEHUtdbJ/reXDAJKuR6Bbq/Q/lM9+58Aoe5dXn2QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H52tV4iBXvtLdc0FRB0a5duISEgxovJvY2eMu0vMApMBz1eRprZQL6aR3SduH8E+zhVu4h7EiLCxOCqyBzyh0ksfpl0TWIYJ/9Wzmhs2mXD1xx4MsQzAz1sRMf8HQtr7PxPeSBYSxwqujHoEmM7ATpZdIo4YiaivJqWECUXUi8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=PdTALq4M; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp4+NEbnwwzV10nvYjBFeL8bGJuqJ1fwFmHoj9TVuwwGu8hEIQ6BjUG99ZiTZU137U8JvNDCip1vHZ4i49uv2hFYgS5q5b2gWiPzc2ZfyIzesxuSn0SzIIIimbKUsDmKSx6Nqb57HXbzxmFaXGTNrNqXV4p/uYeT2xJHUdJW+8hRY4dhyW9U01eFAoBrUXCq6rNLuHyl0/j2crcUER9Um9sLcExQvCksld+f+/KEUTs/tQ+317jDyLMhCqStUyl4WICa5wDMQMQDg2tfhiPIVSIWNVYq462QY20s/Dtuz7/wiGQDk6VDKYun/fDSrvupbsDOVou94RdsLNWZ/ysJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1EzVNM4c8dANwE0Pew6SQrCtWxLqTQHZIpuJUbfj5k=;
 b=p1hf8s0oSpDbfhzOhQCpv4RvYHSAOUn8iUsJIooHCImxaAfZv1cZDXWJG50mNej9RKXy70gMf1F/qK1sw40WbhLapk+BCqVWpYzO9KbTYnnme8pLgX1jAcQaRPK2HgFycsv3IO9jPLjPWndRQs8+gUyX03/TLbXPGC1DDz2WVlLJV73KMVurxnijEj0WAHdHws03hi6ZZDuqlkSuVKWzY4jTAa3P2vLApogWghJ7r0cDNPvFwn73RoFbL19UCBo7yaR5z8Y9WCNsFIibQAQlEYNpp/JeUFpz7gj+UPKU34/aeEDaMm9So0aOMGgTCtDLeuzSX6rz5ZIIsjqHEI5HWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1EzVNM4c8dANwE0Pew6SQrCtWxLqTQHZIpuJUbfj5k=;
 b=PdTALq4Mt/WNLCykAFMemt5oi8Oj/O+KQqUIZS0xROlWK57RZCafxT9yHoaEIwTuqEblMVtU1YDOCvN4G0ToEVMXPJ8SFWNxcGbssSdDZbtwZcUoB44GRHvoxgZCFi3e6r97En8M9eRqpbnEDBvORatMXC+knGp+44yjw3s8x8ERYiawZxKX/APNX/Lfs1ZSDAu+VtH9NHv9JhvcfIOIkfu7Z2P2nGXkwszLMzuNXns2VZOwWftHJhGZB9MKsFnwkyzHvLb/InlH9LoCJB20FZBRvh9zFlEvaETRADpuTbks+GURuLyd545po3wiJQ6RxIN6+A0qXzPCxT77LyeUkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Tue, 30 Sep 2025 05:26:51 +0300
Message-ID: <20250930022658.1485767-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4bf500-ea32-4c36-1beb-08ddffc8dcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jJyxmQLU2JvWvJHEHlyuwQeer6vOArDRTCyteb9H3GHpzq8gRV401RexYal5?=
 =?us-ascii?Q?6CM+5M5ThzCEDBnpuKfNbpeM3hbvKYEDat4UEgBwYL8boXH7Vb0md+1X608k?=
 =?us-ascii?Q?o+FOue+ktUFQaXK0KUbsDDg/2XtcQDG3Q0FD6MGZxQRxYyo6kX8l2m1MgbQE?=
 =?us-ascii?Q?pqSTghvRRWR079lhcTfKfgFikf+VBm4uwMuSD6Q9+1xNM+MJenaf2EurCHWO?=
 =?us-ascii?Q?hLnZGbAmwX4UWSwnzIohgKQhVLi21KBIx2BBah9U6+6aLZYOEMHgrdzJdwfT?=
 =?us-ascii?Q?7zNH7YoCyHTFq+4grpWgbIko9Jef1ze+t4jPBCt1mD/I06UqGYvFV+rgeEoB?=
 =?us-ascii?Q?OMFlB91VcFGKBcR80btrz00FW5Bqd3VoZ3MfW0VRZ436w08nxI5iH1v28KBl?=
 =?us-ascii?Q?b0NRvz3SrF1/TdfTJbAiOYqwuvIazpiFwsTy3AnUDIw3MLZYraWHKw4xuSDC?=
 =?us-ascii?Q?AkBKSt945g1E+tNyqy5S2vA2aqVeEChSfy2IDY3KXuINNp9d3/esU7tadPw3?=
 =?us-ascii?Q?Nfh04hYTRyKBZOMltEd/dOKZpXRgvBq4Dy65YVAk9JTEXQ0XS04/dyzlToNv?=
 =?us-ascii?Q?YxxCY9RuVvhQ21DCynmMtX+wNLEwUJv1JsDovHDLKsF6Wj1fE2jDjdn4bN6l?=
 =?us-ascii?Q?3MlQ7unDOwsx2hUljMYJrzkK+Wx46z5Wcad/VYUWBvFaJxuJV7fk26pd5THe?=
 =?us-ascii?Q?rhhmX88fARWmaVVuowiu0x2jS9Rn7UFt3Ghm6I3iywnKsKmw5rgmqOwo52Z6?=
 =?us-ascii?Q?34PLeQiN+5MOGTeXmMQn3w4eqSG5Frvs+L8gJBvw3xLj8G6PR8XbPUrUXATW?=
 =?us-ascii?Q?c6E7rFn+a72w8TyyM+OPypQ56ca/kVpiCWlojjjkNNJ7t6nzUkswIS+mqMaJ?=
 =?us-ascii?Q?eK1hdxVSUfIYZshD/NIP9tbY7krdWaV2uNFKffDkg9LtRVtG+mlquOz3TxcW?=
 =?us-ascii?Q?91eh3y735YTCtq+WEstdLEhtv1AWX2ly0ti+bTUgjDNQKLBCaANKh0bITmZH?=
 =?us-ascii?Q?UclT7+0FuSGXRE9mrsaNDY4FHKc2MumKc9FM6Tw70KvKfq40PLVwi3fW4fW/?=
 =?us-ascii?Q?fve+aZ4FFHpiDyHe94zwxsQlZ821QFOYo7TxajAnIQXHwQuk8Loj+1U8ndAW?=
 =?us-ascii?Q?/llXXRGKXc0fyLkaim6DGcGA6+OPJKmabEzMyy+j/O9wsTM7dAU96ol3LeL8?=
 =?us-ascii?Q?NqMfqdrvoZ95Jo6VROWMEYLWX5l9iVPYLy8npM7oEc9KDiLh+WcYWj0QOTIE?=
 =?us-ascii?Q?Wvx1LSwl41CP/saxpni2qHETI7aGpVxCpkNE0QDJlNtFXXOXcpgMVq/GdT7K?=
 =?us-ascii?Q?jiXj2w1eX16BUb3+GAlPXGtbuj0qfK3OgwYMFGl81VESezH13LnquLwirsTs?=
 =?us-ascii?Q?OF6mR/O6GYbImQHPkF4E47b0Suwi3otRmJQMN57sTPHzmXTuRVzt/V4hAV5i?=
 =?us-ascii?Q?DMUNbAyEKQ1KX0Rf9dLNoV+9mI67bwDkSu7YZk6mLH7ZTgm2fpz+q17o4do8?=
 =?us-ascii?Q?+SIu+o1hh+3bLOYpuq8Xcx1ikPG+SuuRdzd5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POqOQd60lMVTckmI511Tv8MoTuaiqIv3m/dZM8iqFFGHV8exPdfk02PI/GP2?=
 =?us-ascii?Q?CIqUZF4Cb1XQxYkSWNBPUyyg4FVYLcmOxmW1HAwaM0xgp+F02ePia1BQOP+0?=
 =?us-ascii?Q?T1TQfhnGBjTu8Eq3xr8EQBV4iSsbK8qa2OiUIoYsXUhAyHaV1j1UKAEUwse/?=
 =?us-ascii?Q?g/gcoyQhqjXfXNJbmsUuIY1HPbklOGaVToigZueSW1GcmZbDAIAyYPLnhMGk?=
 =?us-ascii?Q?gBCKC6jKpMDZJUVW4PI7adNS7MCm6Kv50NVgI26EExXTKecKsptnQ+kL9nIx?=
 =?us-ascii?Q?/2Wg/DsFNstJw8xEXIwDKsmEkzyP6fLV2IvOIilBQVATVQQRgPyOS+wXsTz9?=
 =?us-ascii?Q?rcY2Q5bJz48jaT6c0gi0xpYk4y3EBzJ2WjoIdvj+XynqXimbWXWHNwZiUBZ0?=
 =?us-ascii?Q?ijpM4H8qe6vPNHEboJWr4p3WNCQIKX00E6izY5XxSWoOv7E6v223mEMA4xA/?=
 =?us-ascii?Q?KLJ9BW1moHFs1dfAX+qaHpjH5MKzYhLDWQarLldnDrpuz3gh2FodiLUqxD/m?=
 =?us-ascii?Q?yBxTpQN4VD2HeVJwkJW8yEcCSVvbOIkLp43Ss0VNjpwn2HkrYbd8Ngzve4H/?=
 =?us-ascii?Q?vdVkyrrm8HyITZCM8Dn3OqL49+tCohP3nDn+uyiEkTwt1TWHhQbngpeZrhz0?=
 =?us-ascii?Q?mrWi+mGgWlkFakKhIuovGfR8mx2eNbRrZ9n1g94fvrPMZk+wrdC4OSGLToJV?=
 =?us-ascii?Q?EcDl2zGNcW3S6fqvwnnVciA74hAzdbhMqqA6ZdmcznvpYwET+QArIl/bYLX1?=
 =?us-ascii?Q?nakonEzvHNde2Ssi2xIEhBIonoQmkUW+I9czFLmzPHkkDxE/1vD1eDOxzVQj?=
 =?us-ascii?Q?gcRd6sLbkTRYk+IlQ3FZEHV6LcsBy6agTvz5ka7uQyilxy62PDTfAnAjEBpX?=
 =?us-ascii?Q?KLfJZmUxddgp5NJqpo1Uf3lXWyc9KLKuuelf8UFEZ4GN2m3knENB2SxAYpMf?=
 =?us-ascii?Q?iYodSltaLUfyWZfc6dpg1El5AIWBsdY6lKaI+n//4gDVLBzXYpW9pRb2TCYY?=
 =?us-ascii?Q?dIgu8o7O9RTuoVrDO1/RKThKr3igZl+qrQE3xBLbIU9cGOAaIo4ZHhGqQgfw?=
 =?us-ascii?Q?gxjmm/DHNvQAWG+wmWoYmCGMOzAt4MmcntJzK6Czqbeeu+2rpOBQdnsRxNEx?=
 =?us-ascii?Q?nPhyWMWjLR5VxO7/fdB7kg6tWvxUvlEsShThJY2wRr1wMC3o51DcU7bfFvaw?=
 =?us-ascii?Q?YkqeVkaszEuljmyIbT3todnouzTCK++6+xFvByaOqLa6AePKfOf7K1KVL7rT?=
 =?us-ascii?Q?2gPqGCJc+IzKQFMLpXg71oeurgDsCdo7IeRKwNo1Pg+gcy5eJ2E0Ev6ciWHo?=
 =?us-ascii?Q?qjvvlzCtPKw7EGYTAf77sBIOevUEWllX8s+3Euf1fzLFFcS57H8tFYBPvAzd?=
 =?us-ascii?Q?XCjxoSmW5mlDmWmg6f3z7VW2XC0PIAQLxbkQwhaQAhbqMaZBRYSAVkM3Tgiu?=
 =?us-ascii?Q?iugl2dTUMeElN/VMPf1W6y1v0WC+w6uYvSPodGSJozUB2Z7XzlwnidR4CTVx?=
 =?us-ascii?Q?uWsEKpPpkCCzZl6hrQGzZvnaN6etl8l/fm+3XZPgp4wM9kvuBNzt1+WxxfMb?=
 =?us-ascii?Q?EsgfUSwO29gCtcAAchjzBnDBOxi38ZZ3agj6u/pM7tME5YTMno2vDk7g0XbS?=
 =?us-ascii?Q?ofkBFg1+XFMNMzJWvIk2YkI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4bf500-ea32-4c36-1beb-08ddffc8dcd6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:12.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnXyh711yg7tAbCUaIeK6WT/vK66JGug/wa6G0o9q1v3hNX037nCaPUpG3So4k3Gg0i1ujwYiswtFQxaIarV5ECmxszNL+odLrApBKM0+Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

Attaching UBI on the flash with more than one plane per lun will lead to
the following error:

[    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001350] Creating 2 MTD partitions on "spi0.0":
[    3.006159] 0x000000000000-0x000000020000 : "bl2"
[    3.011663] 0x000000020000-0x000010000000 : "ubi"
...
[    6.391748] ubi0: attaching mtd1
[    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID header, and the data does not contain all 0xFF
[    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a severe VID header corruption which requires manual inspection
[    6.434249] Volume identifier header dump:
[    6.438349]     magic     55424923
[    6.441482]     version   1
[    6.444007]     vol_type  0
[    6.446539]     copy_flag 0
[    6.449068]     compat    0
[    6.451594]     vol_id    0
[    6.454120]     lnum      1
[    6.456651]     data_size 4096
[    6.459442]     used_ebs  1061644134
[    6.462748]     data_pad  0
[    6.465274]     sqnum     0
[    6.467805]     hdr_crc   61169820
[    6.470943] Volume identifier header hexdump:
[    6.475308] hexdump of PEB 0 offset 4096, length 126976
[    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted EC header at PEB 4
[    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
[    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[    6.529294] UBI error: cannot attach mtd1

Non dirmap reading works good. Looking to spi_mem_no_dirmap_read() code we'll see:

	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
					      u64 offs, size_t len, void *buf)
	{
		struct spi_mem_op op = desc->info.op_tmpl;
		int ret;

// --- see here ---
		op.addr.val = desc->info.offset + offs;
//-----------------
		op.data.buf.in = buf;
		op.data.nbytes = len;
		ret = spi_mem_adjust_op_size(desc->mem, &op);
		if (ret)
		return ret;

		ret = spi_mem_exec_op(desc->mem, &op);
		if (ret)
			return ret;

		return op.data.nbytes;
	}

The similar happens for spi_mem_no_dirmap_write(). Thus the address
passed to the flash should take in the account the value of
desc->info.offset.

This patch fix dirmap reading/writing of flashes with more than one
plane per lun.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index a39c3ab4af5c..5ad3180ac6da 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -726,8 +726,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -860,7 +861,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


