Return-Path: <linux-spi+bounces-10588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC3BD0209
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C01673457EF
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F427A92A;
	Sun, 12 Oct 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="wkoz2gQw"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046A279DDA;
	Sun, 12 Oct 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271467; cv=fail; b=KT1QkmljbFsa8orXzpxrHscqW1wNM1jGD4uG3eScPvblmVUWB0YZJe6ba4iuvOYY8DTGzrQT5/JYnt4dxJgnP51CgQadD+6B33+1fsVMkyO9El38RGfpt1A82l+T2VTtIcKYSZijJNPsKZYI3NVk+FYHT+QbQcZ6SgeM0f2MBrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271467; c=relaxed/simple;
	bh=zXs1zjwe73k8NBFsZyuBC+GPa3XlTDJdYKLifu+UCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S2Tqzkbob53qzLTTF/0weqnmdemWBR07OJf6YvorFdQyJ3z+O/R9ix62ldsSYO/hB+WLZYZcx2sPs7GLdHQD9TywziuQiJWnIob8xvOdUoicAvksTATrW0lPk6Qv5ebNo23982Ojm+crBMlB0uKyd2fAPwzcDY/bx1ph2rBZeD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=wkoz2gQw; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=totIIHISeop8ukCco/CwRR5xNTkHvivcZWn/3zzLG9TmRnTonsq/WIO1C51J9O309NNcitfC0pkkOCxnrvo1WsHbFPXfZZsshTQeR7HXfmKezOrOeJUt+OulRRmYDwrXttBrS7OfLVwSJmzjFYR2K6O3DF0mPPUJHsmYAJXHGthXAXnIct5DZyIB+fQLgJKmK1scESNKQPlkFWGjuG4HHJpii6Czhpq2PldkXAKvAn1U6niJCZ3BMDh/RQhixut27ggi81fU7CZWE/6T1u9MSSbpt7NzRtOvbHcYOPIr8PlPOsTFT2CoDnZGs8j9AsLDcOFTioVgmLsyfJKLO4K2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=C8C4nqwWaMkSAOA8Uqed8kKekUHDl2w4K14202qyTZ2BAGV+dNd0qmWiY+OReLnLmQFUZektmpQKUznaPBDXsoNy35b/oeiYSo4Yc/X5JE05BSLcNxjiC1OqVSOy49C2YWOEU11imuCPukQpCKcsmD8G+Eyf1ydghezUmTSbe7b7Soht9RUGXQbmis9euGv0VFn0k+C/2TYQPrlusC8uMOrn0AZfcTQZ9hTHdyPEPuS/X0e0O+GemYnBOjuvjpOJHrys6DkQ/2hZeiVdZa4AN6g3ENIRKuntRD3d8WEvdoWk0RJQZs5rcCWECxerYFK6NuHU/JKA1gaztwck3uL36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=wkoz2gQwljdgGhyvqOGewl1tn+Az9B0HdktWBWt8c6EVAAxf9e/NqjgOOTyIsKCBE3LeDBszH9f4x6tylj3s93jtVBETGORv0K8BEnHZJp2lzZd9wnhZn81kY0Dn0shUWlRVnG/oK8B9RCGtdDeRqgTFB3IJZYMGquzQcI7AZoUtqXYXIsvL78gTgsWqoZhJIz4IdFAD3kT5e9Z971qJRub9RB0OpUSMXFLFPvO0JVxldcnkYQ64yNbdN9vnsjf0i86vI4Z2uxZ6nPtocubYM7tOSXESMZGDcuUqoJX2gKFT6VmR+cG3u2bESTvW/wepTXekL/4jMc+tzBbhx2vn/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v10 13/16] spi: airoha: buffer must be 0xff-ed before writing
Date: Sun, 12 Oct 2025 15:17:04 +0300
Message-ID: <20251012121707.2296160-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: f326f54a-776e-4829-5939-08de09895611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQh1lfRA4CZ+xwS4gbq6ROj6dv3QxJyjnV2UQEhDUjhuTgR8ZplwpdREro2/?=
 =?us-ascii?Q?jLV/pJJl20XOJzdSnarse5LxVew73ZoiqKvMRSxV+sHFtE1a6nMOXoPHdCO8?=
 =?us-ascii?Q?yN4omLKRPKwP9KOIu9iVMgyywJzponRWWIKwjE91mYBds9wZlM1AEO/KApBO?=
 =?us-ascii?Q?oidgDjFaWBUvA++Ax/RTTWawQFBAUSyOZ42IBauza0tpJ72cYk6cArcEY56p?=
 =?us-ascii?Q?Scr5UFLxib+3onHugeeXYmbxJafLGE30yF0Tg6fIY8AxmQyLrk5vl5oTQbti?=
 =?us-ascii?Q?oPu8+YnFbJSRM4rvAfX45xR/fzLwiKPr3e2r/HsO5Yh/upC5FUmo4+FxjrD1?=
 =?us-ascii?Q?LMpbLdKUiENFIoOw2EZnlKgFab768/+NX7BQHEVSbv+V6Dso68LimklRTVQ3?=
 =?us-ascii?Q?H4s7amHkXsuJGqVHFiRaagBDwj+VGwqAzyUJNzcS68g5mdqb0JCEPBbosyIZ?=
 =?us-ascii?Q?KrDFbWIEf3ScMMccXReclxt4IZCyTzSaUuaadiY27dFR6hl9PLecXVa8gezr?=
 =?us-ascii?Q?+Rq2Ymt/+t/BGjDffAYTia7s6Y33FW6uXdYMlAjZxA2/IskpQe7pPH2MV/ZI?=
 =?us-ascii?Q?A469no/6SKUcyn17K28rhf7aeaMcXvjr+9zWY41A64Dnw+Zq+c9W+bf9KyZ2?=
 =?us-ascii?Q?Ev31zoy25x9lwudTfMXKCWIl7FqRv6oEiSHqj0euLsSyPpAOj5LsvsYczcBc?=
 =?us-ascii?Q?bS/Jtiy6dCf+iUX588/QZQrdPDIOWrfipX+aSXACNXRdt+3MV6EYZrlMwXmO?=
 =?us-ascii?Q?sHGCum1KRXMAV92628MNy6Ei3welWjjteoVylZcOQk/JQUih60EenWtIBOTh?=
 =?us-ascii?Q?hqcghyRxce3kgj1BP+8yI5RLoOGgE5WGp7VPwLWMfl8reuQqsy6ZhPBvbDtV?=
 =?us-ascii?Q?R2aGHrUUdEwJRlVv/zm2leQq0u9dNG3Irg07j+n2ghxLvYeRpw1qhehqEFo1?=
 =?us-ascii?Q?f0UfKPt2Wo+taE2+e/xYCwNDCV+fBSV69JQomPY0FJpiUqn1IOlfSRJnvEgV?=
 =?us-ascii?Q?sh7UT28IV6TRmYDk1R6yda0GRDY50PgBWvfIq6L7SZlV5Sq0Y0OwZDv1CQ5j?=
 =?us-ascii?Q?QUs67uFUgutknlDvsokIoCgXZSOHxodZV2JaEiTYpRjiFWKoLfirw13csKEB?=
 =?us-ascii?Q?hxQYnwDG9tAptuSX0HhWf4RKdiuzfvlj158KCe+ww+F0rbAVjh7siQFCWLAj?=
 =?us-ascii?Q?WGJRgm+B+kx7otYonGgTvUrLPHPrWixHz2dBxYpl2QRKDSXg26AlWLN6imO7?=
 =?us-ascii?Q?zPdco+KydcpPyUW3nxQfTI3orNhmzj/e/Pq+8Z8T/1Cm4TaKbXiFWNOh80il?=
 =?us-ascii?Q?IWDhS6N6MIeee+BkHWe4lzcKYC3TKjW/fpRS17zdPzHuBhUcUABeBirl8tbm?=
 =?us-ascii?Q?fm4mcpAnq+cFteSbyt17pyvRMIZ5R9hQ3CmU+R8R/vFlIGeK13tuT9u407MV?=
 =?us-ascii?Q?luOplTHU6dZi5fBjtzigbQ/CLWHgae21Od3siKpkRXiUytU1ZWQCRuAPIoZ/?=
 =?us-ascii?Q?npZ2nx4CmOzSI1hwhsW5unD4D3X7tzlJ2/RPnVp5+s9RuZhpeaRiykwi2g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LwcsuY3SOP9ag5LECn+awjWMZUYg31PZAzkJ8OFANx0IgJHg0zZWlNIdbquN?=
 =?us-ascii?Q?oGveNp8gAEIm0yEKgQvE4PJbkBOBHQRtn0R0XKu6b3tr2ezyuvLVDbDgxhuY?=
 =?us-ascii?Q?h/9pUvB58Gm9IKayvnGTuYvs9fQwaXEQaNxgFLFo3Jt+zOtGVJPTjZA87kuC?=
 =?us-ascii?Q?0skapPngzLaMGt/ohH+r6faeXh2zRgzcxjGmowfciVngebf8EIKouZ+ExP9e?=
 =?us-ascii?Q?rOiuwUffdOw/VYNbFuOD2qwmTfCFgtCeyqBNwiWvOiYGmmjUnc/5Goi1Kb79?=
 =?us-ascii?Q?7S5CSlNu+k8TJztcdSC3cuM6NOPd9bd4r9tR/dbe73AScDvOLj9lo9ebyFpl?=
 =?us-ascii?Q?UGP/8jkGq9Chq/5RfjF2hcMLXaaofLmTKa01L3I6VTEIQqKAPJAf/rAab3AH?=
 =?us-ascii?Q?ZMLmdhcb4TJ/z1V3ydFGkKX+V3kn7b/4/6yrevj5ZJykKWrAZdfMenk8D2Hp?=
 =?us-ascii?Q?4Nc4slabKinC34u5KO5U3QLIUS4grP77PDGrZ9YZXARg6HtA9e9byULSc318?=
 =?us-ascii?Q?eFw6NA+7gOZBeKH2m7eF6UpoZZ5r876kBpb+hf+cbUDcMS/qv+DeKQCyx14P?=
 =?us-ascii?Q?L19ARJjENmoVD0nuhhQ8+V1vayXvsTzQru5Sf0xcksY4dyIel+9JriLb6r40?=
 =?us-ascii?Q?vWc0MpwLb/xEXEUkqFYXzqJyfI+kAKQWpGh0VOUVqqz6CgPckd1+7vD7Agqz?=
 =?us-ascii?Q?QhHX3PzxGMSpmw98U/wKzZ7J/7JQ1/OYKpj03vHfNGeYSjnl+YDauQF0XogR?=
 =?us-ascii?Q?s2nQ4rwho+93opK4/3KVlsNAJTVJP43hinOAdsTWe4thxAlDSHvA9RHGmUXd?=
 =?us-ascii?Q?7hEoMIypmDMe5pNExL6nAzXs95s2Tn3KBVZ9b35/aD2ikOdH1wXApSLo9Aht?=
 =?us-ascii?Q?/3r95mcQ9H9NFY6mzsY+Coqxm9a3m/FP2Rc4/WP5L+Qtkk9OPTGS6z6sDRg3?=
 =?us-ascii?Q?D/ZaOG7yHw3ebwQOdOICTr26Q7xvcMmKAYBr1P+rKQlXwhAi7KkrmXFv1EJx?=
 =?us-ascii?Q?031VqMtIzUK3fBMSFvBnV+IKx1eVlZntqvmbyWWYL6Jm5A7G/8q2pXTaZKx0?=
 =?us-ascii?Q?K4HfnIDER/WKkHJmfQhdHz/Jt/xLDGERERXbeHoxiIEEEJXyjf/jGh1QCNbR?=
 =?us-ascii?Q?rIfU+2oxf9fRdiMLJ2emx4qv0rISJ2v1+Tjz1nNyj5kQwy34vU/629nFUw9K?=
 =?us-ascii?Q?ZUTXT3Yj+NP0HSz6lhGBYLe0du7jILdRsPBfW38RBKlK2mvWbU5sl4ycjPoz?=
 =?us-ascii?Q?qTIsvsOxJt9hfOdEnPcZWh8UfIxWUyXVUVaXpC1sEZcXdJIIcvyubv6JjeGW?=
 =?us-ascii?Q?tHL9ma3HYvKNRRmSk4gKx50yQ/89jb9HvZM0ZixoZycEZXO5SnDAeo1znxmP?=
 =?us-ascii?Q?HaYkJBtVI1/T7fwrZLvacFfsLvc1qjiJSliz04aqhB+A7W2I9X/7zUpCTITc?=
 =?us-ascii?Q?gaGlTg0UXbC7JIknUFUO2cLtchF24qrlWavLHE4Cf0Pb2qPWkkbUd8QEdmng?=
 =?us-ascii?Q?ibgagc0Gvo7ksVvFTLOCAMzqZJt+e4ToIctg6ckFyLaORs0B+jUDELhr03Qa?=
 =?us-ascii?Q?gjWuSOzZwby7fygsVU9pgfTRl5UrPEQ5mpRD4eVHzsRy9KD+kleLrc+5N2o8?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f326f54a-776e-4829-5939-08de09895611
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:39.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfXlIl0nn9fKE778uj4can5CavBqcA6Nc5sauXv59XT1U0evxssoxm8SDBo3id56vtSugJgBuefCtebXGAVmVmUKYL7k7wglDXjpiHQHsQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 437ab6745b1a..8408aee9c06e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -776,7 +776,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0


