Return-Path: <linux-spi+bounces-3346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D9900870
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8173528D110
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C486319A2AA;
	Fri,  7 Jun 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="V3/M/C+7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8AE199EBC;
	Fri,  7 Jun 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773299; cv=fail; b=StNC3KESZTbBmQFYjJXtFpWipe9cZPcUyUHUtLIFBXhsGddg40syUQzmDr1VxTeI1YRv6RaZ01Ya4t+iOq8amyylL3Fr+f9hMTh/96yU9UyfnIGnr2h1d5AWvVyhimkSMakrj8Xzex07taySM3S+5dcBAKoKtUdga30TphbOczQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773299; c=relaxed/simple;
	bh=/ruWGJ3b0KeyAsAHKdx79gwm9HqW0FyAl5ooI741P2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EepZO9vBt/fDqIF9UhSSKgzUPogt7dJeFHXClyD6YVmQ/Ge2/D4YYAk2XI3S42kwfQQF00el6Dc5GlAgb3bYchqZXdZy9TRsxkrDH5yc+i8m3zYvCXOj2ISyEp36SwZq1yElMrPU0lS/MTGFxfaA/h9X/OH2iKbWKU6iUTUG3js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=V3/M/C+7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45799T2j027479;
	Fri, 7 Jun 2024 08:14:52 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ykuu21m3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUXdyCFX6E5vy8Xsm+7G7+U6Vso3GKFgx1bEA2VhJl7gI0QWAaGUmI0M5zMNl1hbQqLK1hW2v+qJaqLAsOvu+XoIPEsoyr6VLJPCszFWdv4xy78tZtZMQy2x5sSYSy+Kk9M6i4MBemhTlZD1r23NFyX5CXilTJQ+QTLqLu7u94HnZQ5b4OXldHnPA/Prv1E9+RlfqZ++zMJb7nYahCl+rk9c44mCqsDjgG5GaE1LVjaWWZL2fhw3Im8/if0KonYCDCYnMMF3B/rnj+fgPjtG9CNtPzJCOgm5sxFCyMZ2qCiCvMNPcYUfzYvMe6UBu+YHos2qI6K/v63v9yOm69T1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9itA+JpO3aWb5n6NlirXXWqw0aExgLBKqvHm954yns=;
 b=mpnhCXBZwEkcKG5TpXqRYOnO/1liWWVwGB+vg9aizHTQo+qyeND+9zV9LybaRh5QdbT5AtElJ7wDKwNN46727M9VmmLlIpOUIJkFRl9fJyP6lRJzuAGvwpJGzH/gm0jZgPypK9TnlVD6Eu70WnI+PO/GB5PYyTubG8bQXjfNugVAXcI9TpIGpAI8NFdS1CP24WFu9IEWDm9IimEBbXPEdk29f/UWFOIrsjrAzFGGeNl3NP+ZxkQ0y8oi+U/MY1V49OEITcNGuWsr4KZkTLlt6+sTkxWTd5JMnPNEyswMbcfpppvDNolJPpHuBUN3mZNI5ymrjmlivZnk+5plWJBRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9itA+JpO3aWb5n6NlirXXWqw0aExgLBKqvHm954yns=;
 b=V3/M/C+7hzFxVQEF+qV4fwfh8jmM4HAqiBnhJV9YBRNYk2ejy+/1qt6gH8YG2sd0ycIxB1ZJfAlBsgQKCISTQRc9m/QQfW9rawYDgxcgMNp0n+YGG9Kg8sHHat9vallp4RqSzbn4hb2Fk3nrLWVK7lVHcBBSJR0ZkQT4Jc1j+pk=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 DM4PR18MB4334.namprd18.prod.outlook.com (2603:10b6:5:399::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 15:14:46 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:14:45 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v7 2/4] spi: cadence: Add Marvell xSPI IP
 overlay changes
Thread-Topic: [EXTERNAL] Re: [PATCH v7 2/4] spi: cadence: Add Marvell xSPI IP
 overlay changes
Thread-Index: AQHashOxQrxXgjczM0KWa5pVXoAx/LG3XAsAgAUaNdA=
Date: Fri, 7 Jun 2024 15:14:45 +0000
Message-ID: 
 <CO6PR18MB40986EC61B5D226FF562AA02B0FB2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240529220026.1644986-3-wsadowski@marvell.com>
 <8428babf-5504-4710-9138-a2b6e5fc2a84@moroto.mountain>
In-Reply-To: <8428babf-5504-4710-9138-a2b6e5fc2a84@moroto.mountain>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|DM4PR18MB4334:EE_
x-ms-office365-filtering-correlation-id: ca0daa21-d4d8-4a52-7ad2-08dc870490bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?bNomoCb6uE6IV+9p7dLDReFBjey2+7A8DtA4Otmuqx+pinzWqE4T+0FQYxMp?=
 =?us-ascii?Q?jJHH2BIbMJdkDUemk90yclujNJks5+6hdHIOk3pOef384mJ/7tNQHsOGQ+NW?=
 =?us-ascii?Q?S9b3y/4CWOMx7E97vBArVBG5ceKOvWplFXCSBf6t4HCtbIBlKmlmJCd9NN9V?=
 =?us-ascii?Q?m7teldN6KujLoC4FuZ2zVCMr5KdTDgdtTf13MCJc3NlSOt8qa2uorUVbGaCW?=
 =?us-ascii?Q?yQRoETYwBm8/PhsgmszpAWYvP0iqVDec55rSraoqZ66olGdNJJA5owpHvH68?=
 =?us-ascii?Q?jtbiDxpF8P0XVuDXtkt8OIXwLeNpZ0GsIPes1BdxQRu2y2/SgliM36Eb3OOj?=
 =?us-ascii?Q?AOuBFTlUup/A+fAdqtTKB1pwCiz6g55h+OvS5oP7TuTxu5ydc03ds/1Ehsu/?=
 =?us-ascii?Q?EUEvSDYhxLGFZiCDt0vY+CMwpddCOlof0/Vyw2cvhkAiZGuRq4abYXum9AtF?=
 =?us-ascii?Q?t55ujbARLKoPyWjrqKeh9OF1KQKDDxQb5+PK9H9J9ySlSoySZfYUnVYoA8Cy?=
 =?us-ascii?Q?dCkRjJtBA923UAmvBRxIfXGXJMSyP+sOPONwjutccxLTXfNm6XmFIYnWnqG5?=
 =?us-ascii?Q?mh1g2N5MEY7KwnjfrBi8pUQu9S7lcj+IfVh54hpTvBKkcYZJlL+q4p9KzjvL?=
 =?us-ascii?Q?DOwlBPv0l8wmnGy5unkJhuHKuSxa8Y+eVXZp9UFHLswi3hc/hhp95IbTL3/e?=
 =?us-ascii?Q?rGLHsQSM/YEBYeb7O3Un/EywGElKCG1ZUJ7/Su/3+IyKnzI/tOV9Aii42Rad?=
 =?us-ascii?Q?gNQgGJmNSvCDeG308RepTWpERddk2zWHTY01xaDYtdUgPy2/STEdS4Yuv5JO?=
 =?us-ascii?Q?/1Km4lEigsNZUcyiGCYnVgjfeTMnteOyKuegAtuM8SZxdhtPYrDXgq6B8lUD?=
 =?us-ascii?Q?s3MXpY78SkkaxTY2yb57qKSUw/HaBO8z+E9itwGoBdsqh6I4OWziA8HmscSu?=
 =?us-ascii?Q?EGivKiaYqXebW/D9WSTLvCnzsH1cIM/48pTzZE/NPiqX5O+cm+Cu9x3UA/mc?=
 =?us-ascii?Q?FPqwyyHFpMD3xlS/XcVsEX/QfGEbeY9Q0lft7SZFhof16cWJ5JskPoKRsa2A?=
 =?us-ascii?Q?8OLW/ddDFCkOx8FunXSbsz9Xzbfs57LqnPOeU7jws8qmFlRPP1MN5OB/HgSd?=
 =?us-ascii?Q?FZZK/1qEY5apotJrDyBToY7eAV3y6i8YtmGjZRYLCIx3Gy+lGnD6CzMCHaa4?=
 =?us-ascii?Q?z0fWDHih5FsPKAToU+4PW5ke7EmBmGHSQ71di/ZrHiW19nM9cmfxJUE2CJnT?=
 =?us-ascii?Q?DrEqhtLq80mUdVH+ljStam1QZn8XK+dUhHFxFFnRHiM5mxOLy4J07jx21+V0?=
 =?us-ascii?Q?ny4l2PPp4qA2JOGg7O+pnRVi?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3lWuGBF+6g2+lwthmSKz7dem/a4mlrh+5z0ePaK74LWl4aKDnkbHEPqHsUWI?=
 =?us-ascii?Q?c0TfdBx9qu+8fgYJeb9EDI9ljRiGXZCT+2+G2gXKXp/YmPE9+RVN5nbAx26f?=
 =?us-ascii?Q?yvIMfskQXbWX/cxOH06xJJWmz9wXTJVcvZh0W7ZEfF5U2KrzdorSjoQon6nc?=
 =?us-ascii?Q?O905/3zXJbnvPFgMdCcQzhtr3aXwEiMOgotO7VQD9Ruj3RKv777IxetfCYli?=
 =?us-ascii?Q?nqnbU9OTv3x5YOCiyAUXiRDWlBUN7MpwN3RWw2ekAO8tv2L4y0vqdj/zWp68?=
 =?us-ascii?Q?AlWYJkeIDzYYX4Z0mPewpRUBPgcZQFiikdXlEEN7fEeSF5xHjoDjbdYHX1C8?=
 =?us-ascii?Q?eOQ2K8WGjwaiTIC6hs64f0XXieVNp6Y6rW/7MBjzC/Y/p9cN9hS0PUxys4tG?=
 =?us-ascii?Q?eZ0OuVx9u9gbX0kAy+qsT3s6b4miFB0dFG8C2NW1OBgiFSUIQC5q4qAtLrjo?=
 =?us-ascii?Q?LxN+kpZ6mJUORtsZu8HI8acF947W78VjS9YW/V9a/+9yzBl4FQDYAtUCb882?=
 =?us-ascii?Q?GLPBXetUQC6fd7xQmbPLWnoi1iExqHIp8VyHr9roFxZFjqrL6PCtgZhfyDkg?=
 =?us-ascii?Q?jRBzTGVI5CLuopWlhGQXMIlYY+Odl3hvzENLIC738v/1okQqaRURpZaMs68e?=
 =?us-ascii?Q?D2H6ObYf+31x97QojHq5XL/Mqb7NP9Dlp0qfUyBIX4NRSi3IHn+ReYH/OOrX?=
 =?us-ascii?Q?xQJTTWtjZmJU7+ykz1q5geMb2mXdp5lhEA0+59xiiDwhAli3rV10j69wPnE5?=
 =?us-ascii?Q?fT0gdo4w4x7xLXwbJn0fa/BK6Aom7gB/Cy34yhKPz1QjK+aiDeBW8KunoVgA?=
 =?us-ascii?Q?6s1ug3WRGfCCSuCaw7uP9P/51zFIn/xKkd/G9cywaDz4eID11rmY++rsYXX6?=
 =?us-ascii?Q?VAjdnVu8T1HzuiONoauHE8xaTLL3E1mPK3oj4MYoaDRtciiuCtkAb+iCg5La?=
 =?us-ascii?Q?cpOdfccvU365G+6onnqddSOOOIiXpm5AMx5XFl6U9WjosKF0N1OZOZZNunEx?=
 =?us-ascii?Q?QJCtDJMgYD6gvOChHNlV20u9fgvM0Jkfm272DagO560dvjowyn/Y2zpYAKtY?=
 =?us-ascii?Q?1jqBxRXEvDLxvOQ6qkYG8F+SQbsquBYr7kuEQBhe6ZFUAjgBtgQjmXAaNC5g?=
 =?us-ascii?Q?r8ppUJB+B9YBC5N3k4bkiRx0R++lVxJQBJegrT8kf/1Ad8zi5YKzYHv895SZ?=
 =?us-ascii?Q?0YvP0EmsVRRROTotSdbGPtNoXFEGN38MxMcwK5GBzz89ATLHGQjPyEBZzk6N?=
 =?us-ascii?Q?yRP7OSdK3pJq35NGQhVDDP1TH8ZQ8PM0+MYz8hN4Gcd0trgo6CS+PEn0FiI0?=
 =?us-ascii?Q?gZkYhNe2fIIbiR6m+oyZ+U7u5i8/Q5tHOWmvffUNNtafMmBV7XCvgN4ab+ot?=
 =?us-ascii?Q?Og9TQ78lw+36rGPPdy3e4QxwKM1NMNHnAX+HBSsOzPk+4WMliZ0akVH9zsFe?=
 =?us-ascii?Q?/m/hP+lLygeapCSbRIzF8pw+nRGcx6AYJdJLYzK4tMksTWKa6ONcTKwtwlfS?=
 =?us-ascii?Q?00OJ/LyvaywiRzPzVTXsvoV+BSO5RBZjqLPGJNT7GuAlyT6XLf2qRSyVI0GJ?=
 =?us-ascii?Q?VPmtlSqCBjG7RjE8E/q5CXMUC87ijovnpeY2XLa1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0daa21-d4d8-4a52-7ad2-08dc870490bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 15:14:45.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tW//6oyS//rLKbID/T+1eWXnEGQtFO+g1cn7xh+0PYNJOGf33l76LNFlArH3fJXVuFLr9E1nSb004nRivrHzWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4334
X-Proofpoint-ORIG-GUID: XHdpwllpKqkyczg96kcdF13oJIOaIsTC
X-Proofpoint-GUID: XHdpwllpKqkyczg96kcdF13oJIOaIsTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01

> 5828a861b01b62 Witold Sadowski 2024-05-29  302  static bool
> cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
> 5828a861b01b62 Witold Sadowski 2024-05-29  303  {
> 5828a861b01b62 Witold Sadowski 2024-05-29  304  	u32 dll_cntrl =3D
> readl(cdns_xspi->iobase +
> 5828a861b01b62 Witold Sadowski 2024-05-29  305
> CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
> 5828a861b01b62 Witold Sadowski 2024-05-29  306  	u32 dll_lock;
> 5828a861b01b62 Witold Sadowski 2024-05-29  307
> 5828a861b01b62 Witold Sadowski 2024-05-29  308  	/* Reset DLL */
> 5828a861b01b62 Witold Sadowski 2024-05-29  309  	dll_cntrl |=3D
> CDNS_XSPI_DLL_RST_N;
> 5828a861b01b62 Witold Sadowski 2024-05-29  310  	writel(dll_cntrl,
> cdns_xspi->iobase +
> 5828a861b01b62 Witold Sadowski 2024-05-29  311
> CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
> 5828a861b01b62 Witold Sadowski 2024-05-29  312
> 5828a861b01b62 Witold Sadowski 2024-05-29  313  	/* Wait for DLL lock
> */
> 5828a861b01b62 Witold Sadowski 2024-05-29 @314  	return
> readl_relaxed_poll_timeout(cdns_xspi->iobase +
> 5828a861b01b62 Witold Sadowski 2024-05-29  315
> 	CDNS_XSPI_INTR_STATUS_REG,
> 5828a861b01b62 Witold Sadowski 2024-05-29  316  		dll_lock,
> ((dll_lock & CDNS_XSPI_DLL_LOCK) =3D=3D 1), 10, 10000);
>=20
> Functions which return true/false should have names which say what the
> return means.  Like access_ok() or is_something().  Returning true for
> failure and false for success is a backwards anti-pattern.  This error
> return value gets propagated back until it is eventually ignored so it
> doesn't affect runtime.

Ok, I will rework dll reset and lock into separate functions.

>=20
> 5828a861b01b62 Witold Sadowski 2024-05-29  317  }
>=20
> --
> 0-DAY CI Kernel Test Service
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_intel_l=
kp-
> 2Dtests_wiki&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-
> dZbLTa8&m=3D2Tyu1l8OLops5Wk0jhMClv2KWeHzTLpsaAhANwtcG2B1koElBL9h8zS_z_-
> T8On7&s=3D01Illw-eCdS6pP0W-BnXjtntuLsuJSnvQTwS_t_TVcc&e=3D

Regards
Witek


