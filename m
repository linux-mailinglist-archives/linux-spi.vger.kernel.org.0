Return-Path: <linux-spi+bounces-7499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A4A83524
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 02:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A067ADA10
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FB433BE;
	Thu, 10 Apr 2025 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Uz20wRXv"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3C1EEE9;
	Thu, 10 Apr 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246206; cv=fail; b=RPHCULxhVuIZwHtHCHkC6wLtnxmqQhjHDSbpjR8mLvbkXL6Re2JIOeWZVBJsnvapXrPhTV9ZzGCVX4sReQsGdyhSPumkOYv354j2X2apenXE8hzlkD9PyBA3Yj0T6hEwfI8lTeIUXiJ8e4H59paAw3I2+gwpBf4+AsbPK0+w6Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246206; c=relaxed/simple;
	bh=tNBUklrSN+alLkDonnLs6d0lMtudn9T5XGF0vF2x2Mk=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ohH0F6uJsz/DNrv/6U/2DsPF56Cs3lo9wcLYUizOVe7xYOOrCx+Zy0LMnwIRv94OlsvwDWDnUZsRUGdHVlBB12nb6Zz5yDh/XZGATTS86X8KvjJBrCAJ3t7C8IW8FICbAipf7ZU7V+qCLW3SQf9jpLJPY+JI3aSQ1fshN8u/kzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Uz20wRXv; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZamqnr8mfRcVOjdTNOER+m3DrvZAtJWU9q8pxO4zACuH4D7S0rDcEMAZO75wAytxhHoqg2kd+WxnCTL/wPfSXo3FEfYMUCe0tZ3uwNUzc0QQcm+k7MxLngAiqzqk6fwqu5pQged5refMKBOrCXoOURnQ8olj+oCM+GoKzxBscBBuQRowmd1/bBAOUfXHhOwZhcP5kzNgzndV+ekf4HqZAM6sXu3L2Lw49vbFUErpAQ+y2DxK4+kn21XWjjHLFht99/NafSFfoxw45XvehvLsfn6/o6k17vFynPjvDeP+HVkdCra+ays4uWu1I2UJO7jBdiTFICCJ4QqeGm18CrK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1ldlO/Ozgfyhq6mBOiDM46IQQOPtB5RUKI224qpuEI=;
 b=H/eSEE65evVU3O36jD57tMxYTAvei/Y5sIhbN9W3UivgGlqht9GucOdshuq6dXnjibDxbMIJNPPQarH/cZCWsD93WLIXdopaiNDjJFcoSUB3pp1iuEBoCLv7g79DkQ1h0cANHAsRgOtxNhzzOkbI49vkFQtzqaxk62bS6G2uHygGmsQD58PogNc+eXQU3UHYuxtnEdXzv1eOpI2PMwSbrT2ZSj4q7k07q6LRtb1pxySUfvZHRFfAt9+h39pd0/6ffnHMu2NOlaOIcPEn27t6cU+Wj/aOo2VMuixUh05DoF9btFohlPFd3ApXdm+Echrj4G+5rN3X7Xe0dyPc2H+qeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1ldlO/Ozgfyhq6mBOiDM46IQQOPtB5RUKI224qpuEI=;
 b=Uz20wRXv7uLaFWwD2XWa2DTvXHBDZpJ0kPp1ZD8CQrRXJGGyYxTn3X2D/KF1k9RMJpXaChohzxLtdrUnb9pOtchVPFyChKI2I7CsxRaEleS1OBy0/R0hNj9/POxCGGUtn/Gz8HGpxdeeBrxJVGILjjvL79VDbcWTdSLGoM49ifY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS0PR01MB5906.jpnprd01.prod.outlook.com
 (2603:1096:604:be::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 00:49:56 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 00:49:56 +0000
Message-ID: <87wmbslu18.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
In-Reply-To: <20250409-mouse-of-eternal-warranty-5eafd2@shite>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
	<bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
	<20250409-mouse-of-eternal-warranty-5eafd2@shite>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 00:49:55 +0000
X-ClientProxiedBy: TYCPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS0PR01MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcd850b-d10c-4e5c-3fe6-08dd77c99ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pkiWxvm7zsOo2SpDKSEtytjEgIiUnUORVLbGungDrV1bYD0NOZ0NGvgdKmXD?=
 =?us-ascii?Q?uJAVOsV7F0y0B9JMCl+EVBK4amQnsM7eT6jzyjBOODB1el/9aDGUbvJH1DPO?=
 =?us-ascii?Q?CoPI4vWmsxA42MFj5zBmvaruYg5oWNfP4O3RVZDfFRA5hJn/y8my4fdTOvdk?=
 =?us-ascii?Q?2rDvqF1XfcrpLrrWM9btJxXOVYgqNQ8YWHiD0c6AXtLJEqK0wMZSZ+F7P0M6?=
 =?us-ascii?Q?htAGkJgrwnaycV7j4j8v5LUSHUfXwUES+iPtoT7IdErnfa4kG/ubR1mwthWx?=
 =?us-ascii?Q?kE+ilu6HfGV3ClRypIj+A8Bdctzoj8AUJYILyWvd9fr0wgsLgGLdGMLSoA4w?=
 =?us-ascii?Q?5NC0dk1L8ukFVJXWNsVuvVBYgUi/IGq1sjpzUu+f6ebJO+BWEoV8GEe2/Cfa?=
 =?us-ascii?Q?JiK/WT8ENq1XMkZ9KmQtMxYNSu/0dA3ofZScjXdxPkkyl5YuH3V7lqZNM3hB?=
 =?us-ascii?Q?JazFVx6isqdyAZYxeSnlCIuH+JAj97YVUlk1RS+QS53YoP+nhPi+sR+BdBv/?=
 =?us-ascii?Q?+pEBcl3NHP1cypo2o5O+8humuXcY+axu9nk79EAd2FYRAadCvX6O7oiwQnm/?=
 =?us-ascii?Q?6gU1Wpv8SNDx4BlsW69gslDokaeUGWJO1B21jLmA5fbCbR24fcau/on83QWG?=
 =?us-ascii?Q?71SwKPC2KTVLNhUip3C3/8lcH1sJPw2PmMeLkm1A6vabMOwIdpJXTB3tD8Lv?=
 =?us-ascii?Q?WV3b21qoOCAWJF5tI5z8KN0a8niN0M+iERwKotdOrfdmKkFwayOnVerx0oAL?=
 =?us-ascii?Q?CZM1skIJ2D8MwVh02J9iDS1nRcTJe8oNtFjQeOCkhHUWxcgs9dQyi++lbUeN?=
 =?us-ascii?Q?XG9CP9D+D0GcAX2L3EShwaZHCDKZ7aeQrGyQNkhxw9l1K9aNeSjj04BFqys/?=
 =?us-ascii?Q?vcgpVYJyuRRqSsRrCFHGoa7En2vwAZsyADDIONf7xVjnIJS7fje/RQ5SKEpE?=
 =?us-ascii?Q?Z/hNsgiVYUWxeOwdZ0rp1QYObunbxMoRRJqU0vX4COeRLDX5XDPHRoq8WTby?=
 =?us-ascii?Q?4uBPXjsS74C6lJLfzk+ylrygjCmhnS3UmwKy4XfWG2yY2G5eb3L5ccgDEvXD?=
 =?us-ascii?Q?5naem5ZMsq/X4krV4gth/MegxOxgo40PuCneDUsAQxpg6cFRl0ie7ZTwAn2d?=
 =?us-ascii?Q?40FFKAxOdcNUzhyvmWAmDQTOVGdEkfhCj6upKG0fZUBInIB4ig7p4Lj+Z/6Q?=
 =?us-ascii?Q?rhstPcckj5cymRAqTuERRqL62wBr1T7ipm54SfqeGQios9XWxzaeA7nkbbvv?=
 =?us-ascii?Q?KREmYBWeQ0AMYF1kXs20tymnb7YUxIBLeCUCHPgNMV2zfCApoCROKBZ8hNyI?=
 =?us-ascii?Q?p8RZ6LutbZuMTl8xwJ++K6pmW5XCEvJbgXyNl0TmEFy8iOmZxwR8WHI2Mks0?=
 =?us-ascii?Q?ywrPJ+EgCrzM+1Thom/HQSuxxm2Fb84N2I2v3r1qx90cU6WfsKwYJKlQwjey?=
 =?us-ascii?Q?GqqOCRF7XToUyHJf9U/o0jsXinneRPlb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKn9mXyX1FRI8zsNo60q++yKfvCtEoX2OTJApW2ywswiA5pzD7GqvXQT/+iV?=
 =?us-ascii?Q?cBldNYOngrmsWIG19+u7faHLdXQPtTSalHi+nLQ/bqeP2LEci71MoWqvpx2y?=
 =?us-ascii?Q?6CWoUc2jPXuwr+sHNbySxn45+y0knsfkzRy1gClvx1mgJ6+/v4V85LWcxL4H?=
 =?us-ascii?Q?JgYbHEg+xdFRTY9kE/n0FYlOqHu4dzvKftWAfgR+gYVbz9HSbM+2z7Qemy51?=
 =?us-ascii?Q?onnwddZqFSgDWIbJBwGg+R2xQ5YG16OEGsrLBqLwKTaIx31OlWitBUwrPpTq?=
 =?us-ascii?Q?p+EuNrrvnhasocPoJuaehoJmdclyDWudkInx/Z3Cn5EgTqNq1mpemFWaACfd?=
 =?us-ascii?Q?2yOWizrvNFW25fBJMhcZd/iHz2fVvhR4aZKLf+nj5vB6QCoY+2Sq6ohZkiEc?=
 =?us-ascii?Q?DF4oCOD/5bX2AMU4ttV3rX7WqY5xSwjX9trUL1jCt4mMpHT72yRhoEYVRJuK?=
 =?us-ascii?Q?D1x1okW1WVJ/O3j++QXFwTu5/pkkqQqZcUbnAAZ5RW7gVvnVmiPBhowjimXW?=
 =?us-ascii?Q?csFnT+Vom7PDgj6l7h+L7VLvg7KfJImz2xPiFp28lRIn+YlxRjFart25SoXF?=
 =?us-ascii?Q?OUidLG/jdVdkXPTG6lF3oG7Bb3yy3KSMPFOmVtm57JAvXxREHDblG0p/ZwGg?=
 =?us-ascii?Q?wf8VGquW2e3VmPxf1o9Ya8lJJv8D6NijAe83QQy6lPE4OWxUa1mstBBk7yCv?=
 =?us-ascii?Q?i0H40OcY5scN5tl3wyCacGHQcTxSFlEOyoFqdRKGIZ/Brjo2KD3408zIKjuG?=
 =?us-ascii?Q?WYKjPK0F7wyFXVJ0IqNEro7z5iUiwL59NfkKptwHyCt+cGR/6GTRnulkCtIb?=
 =?us-ascii?Q?igeoFeDAcwwA2YqbjsUIeAUlGdF2Vre7M8YV4nhxK/jqUAcyk/3e6OEfGpIa?=
 =?us-ascii?Q?LIcY3Ok8/7QMpkFhDoUc7bi60jCYZU2NRzCEU1HuHQs4bZnKy8oN9eINalQi?=
 =?us-ascii?Q?pf5QMMszSTLkR98YMPCTJh5WY1pbETqNIy5gy+A1u5tHYnXWR8CRuuTzULbQ?=
 =?us-ascii?Q?cFdP/8TkV2+1udx9d9kBUaFa7Mc9gnkonzMzCR7dGLEXFHHPk9VuL1WvqI/H?=
 =?us-ascii?Q?PFBHE9jS5p+Y/WvnMM3RXzbh/Yvh7ZpL2H893WvOpGgmYm5k9e1/POo3vVAE?=
 =?us-ascii?Q?tZQuuZvRfBKmSTMI7gzSsSF1STjUMeH+Wv77sseGCHix/mtm76ILre1ZHYNB?=
 =?us-ascii?Q?y/9UBNY1HD0T9KhRQOKv7zZLuA3tncpxy2fDt09EJtpJvwnJnuoF3O/ovI/Y?=
 =?us-ascii?Q?3MAnkjy3cHuv2kMVahvXH46/elN5YIYLzZmuhi0K1vvyXshQKZ2LjPYERQsY?=
 =?us-ascii?Q?M2crPJrqhmq5OrY40qvGGTrVIgwZo50SnhqhN7O4CtMHtCdXQnlvNx48Yes9?=
 =?us-ascii?Q?0YsSAqWEJ7fidYWU0ZH0lD1DE3ag05gCIVf7H08gvwl6VP6h04cJTvXMF1Mk?=
 =?us-ascii?Q?OYUp4JMDNodG9/EMlUytn2RTPvchmp8tJw794xnPeL9TlbVGt3zme+EvCdVz?=
 =?us-ascii?Q?zuyWLIMP7/tlxWmm06RWm2knrmGomvt1XdHmxMM+LXbs97axfDoA6998mNd2?=
 =?us-ascii?Q?+52l3qIqLnLHMjCfaRVIgzCkXjUmEz4NcVKc32mSjRLJPntbXRUVIV3SCGQF?=
 =?us-ascii?Q?H8rusxrftqoIn7/lvw/S/uE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd850b-d10c-4e5c-3fe6-08dd77c99ccc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 00:49:56.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cvLcatnzB70oQGC4E+0glZ1OCJHgCnbChcCOnQgdhGWFkC4GFjL/h0l/2aK8FA/0UUJlgGz/mctk30FFrqkctWAK+omYInvMkR1cQOvQAcILHKHPJRB8G5u4JEgoqH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5906


Hi Krzysztof

> Yes, probably. Although missing cells is easy to change but missing
> protocol, like this patchset here, is quite more challenging.

MSIOF-I2S is using MSIOF-SPI's property, these are compatible.
The diff is I2S is using Of-Graph, SPI is not. Not so challenging ?

> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: renesas,msiof-r8a779g0   # R-Car V4H
> > 
> > 
> > Use expected format of all soc compatibles. It has been always: SoC-module.
> 
> ... unless this is an existing compatible, but then it should be in one
> schema, not two.

If I merged MSIOF-I2S/SPI into one, Of-Graph part will be option ?

>> where to fit it in the DT binding doc hierarchy?
>
> Does not matter, whatever fits better in overal picture/purpose of this
> device.

Can I put info like
linux/Documentation/devicetree/bindings/sound/renesas,msiof.txt

--- renesas,msiof.txt ---
MSIOF-I2S and MSIOF-SPI are using same DT schema.
See
	linux/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml 
-------------------------

Thank you for your help !!

Best regards
---
Kuninori Morimoto

