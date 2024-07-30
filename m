Return-Path: <linux-spi+bounces-4093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9E9411A7
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951861C21165
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781B18EFF5;
	Tue, 30 Jul 2024 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="iOlzyyWa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FC1E49E;
	Tue, 30 Jul 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341835; cv=fail; b=orl3ouFrNQZAjU1wWmvDO5zUBhnJiI0q1rLdxXvN0JOe+y9lvaEHodMIPCVxPNBMXZwdAtc7pX5UFEYDEa2EU6vkMd9R87JaH/3clwgvs/RXms7P7X5zTwFsCUqP4qIGESi5r9XWozaxsDS4LERdKxwySvIXKcWd2qtITCZqmCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341835; c=relaxed/simple;
	bh=4d53VszjUAEweoatpWLn+EfCl+CkDwh6+pfQJYFRXWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PbzM3UI2LAGlEGRDgkUT67zEgbWPdW0mvQ2G2XJJJkHJGxATwsZP0If0h/BZdLcBjsgphGGgr9lLRJ8Bk6Q1tGfTVxXxvhpO/Rzyl+qcjVt1gR4ytd4s7U3PjLs/GvaDevmYV/tyHo1Wl5/2Mjp+aC1ZJ8jMI9tFuR8poK/Oa+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=iOlzyyWa; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UASTYV029034;
	Tue, 30 Jul 2024 05:17:06 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40n0dqspc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/kJhuyBsm6wVLK8pyfF2tcCBcXdEsp4XCAh7OWG7gZLmdyVvcXwQBw1dSi0wFgVxO1GuoKUYJl2r9DoiT7H4zmW96DQu2lGWd0TmSSTsbWUiQJznaDcKXtfQZOgTWR+dFutyyQXT+zIr4QX6sCwF6MJb/w0xI24dnkp3DW5M9fSlbJDIr98TubZzra4r7oPpF7B7al+mz8cnuXoH0U0ICidjnmQUbVQGp8YsQTHvVfwyqSxlYkU9n6WmaYXEyU26HgwVemu3jZVxfB5dZMTT4yy05dZgtKVQC24F7WcJszDUqWqaP6YEZjghNLnHKfpCl02ER5k9dAbHAZEem+KpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4Kt6vVXZlp1M+cDW71YfDF87Bb0dzVY78lkt5N+4sQ=;
 b=drw60CS5VORFtzVPpXmVWCQat66x+WrsvobgfoxBdvCJ7zlXGH1YtOQq3eRn0O/Csw6aBilRsECvxPrJ1O1GBxSZMZYRFMJRb0EI1BtXHz6Xslg9oIHR1LAXdeUZ5j5NAiat7fWjbvOmv++9YyIRtpay+22wFG3Ozy4mYg0Gc4eg/KIrbqaf7l1cmGnF7ZIe6pWVJRBJyTXAOHdcMr71X0+VwiZarhK0weV0CR6rgYGK9/fQmC7fj8KnW0iD6HLH4Ynpg+WiB9XbtPZr2tP/iwqkgSpaRJ3D4MI3SvSZzBY22PphNtJ/Qx/ENodGhKluHA567qEP8Gj8f1m3BTyo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4Kt6vVXZlp1M+cDW71YfDF87Bb0dzVY78lkt5N+4sQ=;
 b=iOlzyyWa3qco0elkaKSNRfMB/JcaPAQnilvuMvjw6D9+bkPQm9BKOEf2TB11k9I/mKXuVW2BNOwHBDOk3iE4tip0+WlrDe0dKznId0voRNTr1ZQ0eq4+YGYJMZhvMSNrdIQpanRUzdq/aIWXEIKsYcOf42DrOjKC5XblKFr2fis=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 LV8PR18MB5867.namprd18.prod.outlook.com (2603:10b6:408:22b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Tue, 30 Jul 2024 12:17:03 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 12:17:02 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v12 0/9] Marvell HW overlay support for
 Cadence xSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v12 0/9] Marvell HW overlay support for
 Cadence xSPI
Thread-Index: AQHa4nYAt1C3XoFWt0iFCJIXkeRRt7IPKo0AgAAE2PA=
Date: Tue, 30 Jul 2024 12:17:02 +0000
Message-ID:
 <CO6PR18MB4098F2A7A3B0ACB6EB840D8BB0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240730114534.1837077-1-wsadowski@marvell.com>
 <6f8adf04-54e7-4fd6-bead-60122c7302a3@sirena.org.uk>
In-Reply-To: <6f8adf04-54e7-4fd6-bead-60122c7302a3@sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|LV8PR18MB5867:EE_
x-ms-office365-filtering-correlation-id: f013efda-daa5-4bfb-fb75-08dcb0918502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n4r4ww8PzoVZzjoLDSkSbrdZVoMu4ny1qvY6OZDXzZVpnqC1YLfrhU29Xilx?=
 =?us-ascii?Q?oefti8hF8QVt9w9gPZj8UkC2FZhUUVTYi/WgaXUlBn9ZC7oclJaUJ0yom+Tx?=
 =?us-ascii?Q?Vp1/Vfh4Z6A+r2qrRzoezg80YxU1ntOjzfaPzrjyoV4Rk22Bx7ZpwATwxwTx?=
 =?us-ascii?Q?WM1GwlpOqPHLiqhcoYeIstSolk+QSmCXbHh7zyKuKAKg3q0YavyiyhnGH0ir?=
 =?us-ascii?Q?cBuroRdarAdxmHjvFQmdjEEZiFCjyl19PZ4BYtjQZf1dV4iit0h1QT5HpF4R?=
 =?us-ascii?Q?+UBcCghsEYXA/IDLNHDF2VKTbZM1Oo9MiYxblGmixe1klLBOjQuuVKQmV+RW?=
 =?us-ascii?Q?hhdDCuM4boE4kyDJTRKWOezrjIhSbPCnjcU5/efkoRzfNvWX/pI7oaV8M5we?=
 =?us-ascii?Q?Unc5Sao9KahrbzYg50XJxcVUz4tEpdtoXzDGbfGC+i+eaZTSU3g3RvVb4bVr?=
 =?us-ascii?Q?6EoiLUThtsD0nLity8R6wa5QI6mXOZFT69fwfAEHG+hEOlyN+Ng5JCZSAOKs?=
 =?us-ascii?Q?jVm6yGuybI9eP8DJdn8IDqNXW1MB9Ppink2UMj6dv7OiSmnoNe0YYsMmTZk2?=
 =?us-ascii?Q?RUnG6Y3EmK9bb5S8FBhL9cuJOPxDlP7qT3bAtuGWIJNpVUF863fPeDLZ3dt1?=
 =?us-ascii?Q?1hNdlK2bXr7GGrs5BWaF8tHc4uA6VsVZOQ3lsXxpnk1jId9dtgBJ+oJ06iWV?=
 =?us-ascii?Q?TDYJQQ8uS3+neOgqJweOxbBY8nkr32c/xNsUW/OQ+Yd6ioVKkUmyMA7VafXe?=
 =?us-ascii?Q?y/zMDrQgPPUQJ1SmOv9zW9izWvKyiuaN3EfeHNMcTQGeGNOM7a5D56HzeyBd?=
 =?us-ascii?Q?owyw7ietJQOlKL4TwprMBtiWVZqhzTW0SR8QaRWpcrDjYPUe7GGDIdyJbCIs?=
 =?us-ascii?Q?YfH+5CpjMd8sZvrDYehCAVvgO7WP+RC37zgMQRTIWqOxds3eeUzUBdAWp6Zu?=
 =?us-ascii?Q?RTMhNPouPwfVmsCDuZt/xAOEAYOu8lSKjNbOiQCe+l76A5sTKQ0huPrEnwt/?=
 =?us-ascii?Q?JideZFteHZ83F2xBvz/6UMrq5TV1iTHjjaq0Vuv7aSxKwloHtsSUb08Nzjzw?=
 =?us-ascii?Q?JPUu/7vqu94yxoySaaVP89RkxGJ5ZX9RX30BZh+74jocq+LIHou67pP/pKZj?=
 =?us-ascii?Q?5AdRguLYEEcfMzGZXu5EbH/nrlwCseRJ9fBUYzzcKwJr4EMURPfPTAUodBbt?=
 =?us-ascii?Q?D8bPiqFXubIqu/kf0QnhsbH4KiDVAndMKhJrzvWvfe0l1qSwy7VeIz69Vm7Y?=
 =?us-ascii?Q?MlOXsrphSPShCElooiZKxN6EiRe8N4v9MB48j+O8QdtDxcFMptc90Hfn91va?=
 =?us-ascii?Q?FBwDjBeqEzvMyiVqHkR0edKCJEOKXhWj8j4lNiie1abfFp9KEOps2CD4WpVd?=
 =?us-ascii?Q?v/Bkmx5/jKHY3+guYDjN+qDDO1BqRk9lqm0hMOXVCibpGN2/Ew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LfcszFSndbmrL33HgQ0zRJ443ZJqxT399pMYPdb9ABWgqRqkNea2S+y6vBsT?=
 =?us-ascii?Q?wiKvbt/Qz+wmN9QikIlNAvDQLDKoKspRsNC7IehhlsHKlSvbfEA8GdfYYU6B?=
 =?us-ascii?Q?irpP+50Tq/oKBepHvxZE7Ymu4gaRVRgMDGDr70uvdlK6l+aI/LrO9Sd91XjX?=
 =?us-ascii?Q?rwFmfS/FQKGjqOymUiZb1fVb57160ydMzwrkGgESK1fg678UUvnC6r8k8DPx?=
 =?us-ascii?Q?KCWiyV5fwyPBtBsjtQjRh8WCEIRGPM1HmgQFRQGmoSkTmplevZ4DuT/ndcVM?=
 =?us-ascii?Q?5SaI0H5ZqVfIPPHwV8IVPl19dWly+4Z7SCNfir1HAi4jTGuNvEx9q6VcW3aE?=
 =?us-ascii?Q?vhY9Uj3JKWt7pRxIFbUBtqGZPunVxbZKsIoj9i3jVaO3Fsh6eEwKbFjw2Frr?=
 =?us-ascii?Q?wNxrJQlevMrYAwquLnrq5i+fHyoNH08UA+nnNYUYhXPGuhVYVpA023BkK5yn?=
 =?us-ascii?Q?StJua7ZxLHAI/wl2F3GQb/TdOjgkln3d4VYXtoEriGfN5Dm3Bex3QssPF2OU?=
 =?us-ascii?Q?T0ADB8kCObi0y67f0cdaCttdcgv2S+I6Lh5P0/2y0ltnjtwSFLOV9P5SZG3+?=
 =?us-ascii?Q?5Vi1NY//GSu+Jw+NK+LomtG3UDib1AYnCjQp6spi1XCoUpWfbrB+jPhcZn9o?=
 =?us-ascii?Q?/KuYh9AwpspYZNCmMjIFahQKGF35jzITPV30lOezNc12GFVZDLUgXnEBl95B?=
 =?us-ascii?Q?GfOaUcOF5hoXk/ejr+15ej9thd0XjWbOuudQsGS10oRbHOMQ8+9rPbpibLAg?=
 =?us-ascii?Q?QtZ9RG6OA5kFfXsKrlb/Yu0wT2yO61KiRayt0anj55hXvQG56/jd5xqU3JeX?=
 =?us-ascii?Q?pg9oFJ49+kQ4VPaVcVnPGm8EcLNMiOHEtay6SMzmUXopvaxmDNBI61ZrN2eG?=
 =?us-ascii?Q?gCB/ph21ZLE9Oyv7Ssn+QNkKCcuJuZOUOCwR6KPKvjir7eI05lm2+MkdR2P1?=
 =?us-ascii?Q?CFHBESfZU5nlXGFcy25x0RzCTaSBXoHpCTEVQlkJtAN+a5W60PfZB1JS3PnA?=
 =?us-ascii?Q?ezwm/PMNQExWYac0BswRzSE5DgM4cOH2qjgeQ4kXCXfp6lnC9ikQp1hIHhpw?=
 =?us-ascii?Q?IdEkoUdsFo4mcLGFY9j+JyPXyyIgJC39iMbj/X2Xl9wB4blHSkzHgSW2nPm/?=
 =?us-ascii?Q?Rr0ZaeMmyJMJDDJqbxQvvLqeuIzAhn7KqhQWueWR0L6yvMBvXHL/FBlbpxAc?=
 =?us-ascii?Q?X4stBXUWVqrkPn/5TQvQz7306ViLCbYIabGV9LGIUEK67iPAWOT8QhabMiS7?=
 =?us-ascii?Q?KTqyFl1U4dfBX9NH0+AIDZnne3VBPpwGPjhfsSxG15GoVu7zFfoi44e2fb5Q?=
 =?us-ascii?Q?BUU60wxOCdqYuuvYlMubaRZrhT5PWHhqCjUNKkBgOaO5s+JAZo4lkc6iJ2uQ?=
 =?us-ascii?Q?a+WGGERAf+DsOmBzXJP043fOH7FMQakU4xcgMQaKr257c8KfhMRwllKwNdh3?=
 =?us-ascii?Q?iUbtGqY2EGY0kVlmPt20m1tMlKHQLuzTQWDUW+k3Zwpo80o+rgtRlHYFwq5O?=
 =?us-ascii?Q?AOJpf5toXbIyGU6hy3pQEPUFvS7MqZm/o8+JdmNxmptwxc+G2S/OylP3+Gdc?=
 =?us-ascii?Q?8dFBh23qNm7rNR3yRn2B53kHwbcTsyiRP19rEs7e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f013efda-daa5-4bfb-fb75-08dcb0918502
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 12:17:02.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFfzvHsvvoU/N33s8uH0c786bwZx9yw5+jhwp+fuHn9WDG68jrOIiPVcnZ4aMRmlTkv9vwacBsUhR2EVwJtESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5867
X-Proofpoint-GUID: -PpTc2XguiIwEsOlvZgT2SdnHkLvbfgL
X-Proofpoint-ORIG-GUID: -PpTc2XguiIwEsOlvZgT2SdnHkLvbfgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

Hi Mark

> On Tue, Jul 30, 2024 at 04:45:24AM -0700, Witold Sadowski wrote:
> > This patch series adds support for the second version of the Marvell
> > hardware overlay for the Cadence xSPI IP block. The overlay is a
> > hardware change made around the original xSPI block. It extends xSPI
> > features with clock configuration, interrupt masking, and full-duplex,
> > variable-length SPI operations.
>=20
> Ah, sorry - I see this was for an already applied series.  In that case
> you should send an incremental patch fixing the issue.

Ok, I will send Kconfig change as separate change, and v12 version should b=
e ignored.

Regards
Witek

