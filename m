Return-Path: <linux-spi+bounces-7602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5957A8ABB7
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 01:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308DD1902ED8
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B527E1D5;
	Tue, 15 Apr 2025 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AQbHAxsj"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010020.outbound.protection.outlook.com [52.101.229.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48082226CF6;
	Tue, 15 Apr 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758160; cv=fail; b=b5NRYY+U3dek2j2JuuLkcNxEc6wy7W/gaWnfXU5gsUR/hQWIz/Qn73+XxzF/qaW3hLs8a712iEMc3/5qapuS52UGHS7ylazBUs18NoLPVk6+4xKiTHsqUN+H+vJJr42cgGCyKFJewPLj26fbV5uIop4naiNZ+PuR1U4R2T+g+oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758160; c=relaxed/simple;
	bh=4+XtwPtrLAGnLJJIin/teqWuUwMcIQlbMH2eTTvTk/c=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=T6ZY38utcwsaQ47pIGyLAWNdPLTeHXstNpNcZE4z9ATxIuAZH13LfrjTO94ZcWdRMvgQfB+zyUcwmoKjrENmtuEUmpOyxlf1cDZQOJ9N65N7HZTQFu/fClpRckIAy8PjFmv/+/YJ1uMitOqa+U/qfXeZclaGdzo9h5NMSmVEwA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AQbHAxsj; arc=fail smtp.client-ip=52.101.229.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOKUyx713DN75EuEc2Ge0GwYSHCbObwRMmu/0MYd24PNSkyQefc2+5baFrTLMkhAAlCaCZ+N6xmkdNAptUx87hhsAI6Z/UCTcCryLXFJNUHQCvUz4Q1a/8XcfPXEZxMqiiLuXfePAGQoH5wF8L+LbyBi3zdKDNTfP+uQ15JbpODX9hOSNIVsJQb+fpympsPgcpKJzfAXaikUNGy3miBUqvognnqXTZp8tPX0yk9xdNnOwQOXE4bGT+xOr95vcHK9NewTL1LLh+vrt04hFrPYgBL+wY3wjbu9cMIUUDo53lGP8Nt9yVn1mcF4lSg6heU9pHNq6noLPGkcYwAJykOvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksvlep3/Opfwn8NwA13b1NwHPB3D7drxMf8JK+6GnlY=;
 b=gG+5yBGVeLRd4fiSLjgS0UY8wsahPXetsCY3hPg9OOC9rh1luopsFz6h5/eB/HVrvQUNnPJua2Velgu3q2g4vlO+t0jK+aGu3+tvQvlHaqnaQxSudfL0kpjrHRKvn7CXeSrKNMSj2bwtthhTSX8qIYRPbtBjYXk09PcFPfgQ7vyWG5hwLeBCZK2ezGGAgrMZ9BdDlm8/3HNCAlXfFCaOcCYTfLcu5NML4bY2UQglyaXh+/SuWaHjUu9Fuk9tzQxLYqlbwd20LoGVm6/lYvkQrUdg5p+VUD4Kn1Yed3vwqKNfYtabWiy7MFe/7WWamHbdvLnbjV3N/kCmEHsbBAeFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksvlep3/Opfwn8NwA13b1NwHPB3D7drxMf8JK+6GnlY=;
 b=AQbHAxsj6sZJ4k1LrwxIOCw6wJ3I5HTekVblzRh2TcmPewCX6CT0FLGS/c+GRJRPSTrOLPI7DpOaHPCCx+687U6qb3jCljsXvXAANk1iCTHoB8qsmY1BvgyjxPRViO4rZRG+9cufBfAu1izr8jWTTAPMYlAn8NXEK0ArRiYj0iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB6143.jpnprd01.prod.outlook.com
 (2603:1096:400:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 23:02:32 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 23:02:32 +0000
Message-ID: <87lds181vc.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 02/10] spi: sh-msiof: use dev in sh_msiof_spi_probe()
In-Reply-To: <CAMuHMdU3ieWELcj8Z2zQRJ4gsjz25nK+CZi1qDJByUUS9f1teg@mail.gmail.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbm1a4b.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdU3ieWELcj8Z2zQRJ4gsjz25nK+CZi1qDJByUUS9f1teg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 23:02:32 +0000
X-ClientProxiedBy: TYCP286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::7) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: c835fa9c-6009-4f9d-1e6c-08dd7c719a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJYtDBYdbQvLcqHucPHBtisaIjm9LY6w2DXiahkGcMKDgmchjW7fVodj+WXH?=
 =?us-ascii?Q?Abk9Yci0rwo9u+8Mu0T7a1l9W2O59ErT5fdWXdBvwetq6YVITbXPdEsif4tW?=
 =?us-ascii?Q?pLQw21mYh253tjGnqgkXxf+jYz0uHP0TmsXE7Vkc+7fzzQDecJkNXa6Tb+qU?=
 =?us-ascii?Q?ftus2e8vcpwkh99Pq/jpyBFyHb1hcc4DbZ8BO0ruGIjM4+PYef8LDSTgp4Zj?=
 =?us-ascii?Q?G/cjSW4yrxq/XXjlb6aO7Fx7lIAo5csum88yt2+iz4Q56f28G5WvKVcPNc6W?=
 =?us-ascii?Q?eLVZ55C3nkSZPl8T8eKvqvR7WzNG3/33RgGrRxU/Hkala5BrxGBCCFGs3CYp?=
 =?us-ascii?Q?HbhlFi+iaVZ++Rpzi7tWgiwN3fGFcemeNm84UB0XriawIh9EhVtyBjWQneY5?=
 =?us-ascii?Q?qPXRhCshP4t3QHknO60BALRQ2LKle+RVApxmQ96We+dwurzQynhKbDrWnVFg?=
 =?us-ascii?Q?iIcTLmIMLp3/FHcxpReK1JWsJ5knXfcA2phEq4IsxK+r62ge6KjU5xosp03J?=
 =?us-ascii?Q?WYt0WjsDXgMZi6vJNBF/L6rOZkH9kWqkvmyFXlnO/IF2PC2qPcWylQksqR18?=
 =?us-ascii?Q?nfQ1n1NaHnd84ukoz2MkXPRCAqqQsEDp4bLjP9vx+ShrTGuXXks73RTcAlS4?=
 =?us-ascii?Q?GeWfR+8PYLoy8IwtAPVB97084kbcgTsGykaaHoj3tH78hYyabFew6xborHBp?=
 =?us-ascii?Q?yAzrGz3I5hL20GSaR72Nsm4LPjHmSHmpbRBEIGKke+IptzQv0oe3CaMXBDoD?=
 =?us-ascii?Q?TM/luIrrtYbKclQvj8KxwaDAKPlj1QPNnJiqeTXDqMXv+xjOk+X7SR75+1lA?=
 =?us-ascii?Q?tR0m3s/I7U/HA7ScnaeqwT9ng4G3nlKobrd8BjL7sGI2uFDC9IzNecUVhvDD?=
 =?us-ascii?Q?B6xBAy6nE03iPCQi1rHAN/Vl8noKcuvIq0oHSw4d3k2fDbpM7wUIuYRuzpFB?=
 =?us-ascii?Q?OOKi7VkB8l/DMUoE/mnJVjNoNUtJiDRHwO/OZSsH0cSjjnNp7DaHeNY0ifM1?=
 =?us-ascii?Q?NBGg8vHxA2hxOOQ+4VisuYT0ipRgv4jP/GVyz1oZsADH6sI2vKlOZbriec4p?=
 =?us-ascii?Q?mTryxP0jIvimk787trGR2gLKOTVHVrmJbUCf7tcdOyG5KPCwgCU7MjqdJTGz?=
 =?us-ascii?Q?HxAw7tiDM/uWDKq1KUTF3Rw1nALANlF1rHOISLgyTfHgY0XyAF+nNt2zHMqc?=
 =?us-ascii?Q?umGdhd3b5dzSePxwE5waK/YFwfgrfRjjWpWQ59BGWlS0ijSL7ILHVzEhdLoL?=
 =?us-ascii?Q?9T/qDbsfYcloKgpsgXQMpW6f+jXD4cYMqm1nBVtYzdI8M1OtjuOrUcFHXWhO?=
 =?us-ascii?Q?o3vAst6XvmOIdFhfaHTZn6PtbJbSbxk6S255ZQTMGU1h70evH2DvadP1BNlg?=
 =?us-ascii?Q?zqfV6wPn2gNXy0LWzv5V7maB6Na03oDzaZbsx924P6WpmbV1zpLFwJucTT+r?=
 =?us-ascii?Q?Arjf4xFSVd3z27mp4tc8E0a64ZSjUdi4Py9/TRWbOWl/WR3vfHVDTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bdw6UWcC6yR9rMO1AIrRjnLS/iMWZlMaPI61+iWaedneWZH85wpVhzHm5OYe?=
 =?us-ascii?Q?28nADjwQenplzSWIr90MUkMpO/Cp3LivSXmaSh7fZqLsXd4JkR72Qi1WTuVh?=
 =?us-ascii?Q?7rnBlL/A/vmGU6UIILfITHSqicg46rqCOSSXQ3l0E3XrTTvmzcnNt0DpVrcj?=
 =?us-ascii?Q?gDX63Nw+ELuC92fVZx8tfzjetZUeUiRrhwj8DKznKxm4/FFQn1pX2UdoUOb9?=
 =?us-ascii?Q?ssT614hxTw26qrwu8SHsuXM+wgUNiYBx0zNJSgZMUXmiPuromYmbbWv1jtWt?=
 =?us-ascii?Q?RxTKv1TqhSjykZH8vP6nK0dMa7DDACe1mb1O5DCuudIyh/oiE4yapV0/CTIY?=
 =?us-ascii?Q?StujzVHU+aStD1wlQJO4csqrwfQ/IqVwkXMhRBMetOMTE5afD0B1RuuG9614?=
 =?us-ascii?Q?8WsX4wyaNOZTPmv+L4bC1kIr1vKTZFsvYmXW35qMpzwabFsBU5ylfcFQkSfu?=
 =?us-ascii?Q?atVG2aJaMnNJ5eWbN8+XYNtPoiuY+qgdZzVX32rr1/F5FY3+S1KwJ2l1bZxL?=
 =?us-ascii?Q?r7BOj+zFaG+QZGJVx3Y7RYB9it0QZF8cxH7gzBK/u2S9POXbK6GDjX1nMfY+?=
 =?us-ascii?Q?uvLddm7sVu9WBzFud0uKcaTuulYnEfk6crY0Pr4O/pAnDLl1jiOGEYSwTwBq?=
 =?us-ascii?Q?wLGT4Vehv98Eq865DnlMz1ed26nThJui1z1hBnesZxZLEQPpFntHGAKQ+4rp?=
 =?us-ascii?Q?e5McpYcBl/N6ol7j5o5m/E81rB2hhih+XsTK5i/TuSpxfkV2SEfeerKBYmSr?=
 =?us-ascii?Q?qVO0I0EBifBz4w4k7IK4hrCQHAfpZUUF8t+WqZd/5gi+M3wgciO/ScRA+7cI?=
 =?us-ascii?Q?O0cGbPXPBJNSK355noqBh9AglbKmVPZIDXxGkwa0nltrD4XYDTi6mccSOxly?=
 =?us-ascii?Q?DCeXXMZ7gB0hi96Fd4mW/szIw1b9i0czh/eHm4vt6WlhUni26kZVPXp1nKwV?=
 =?us-ascii?Q?u3NeyPojOVsBMn+k9QlnpxUxAKbsiIhc9oIfP9ey6k7Cpt6A945Ahgh0iCmJ?=
 =?us-ascii?Q?2UKvmmyPngWTLPBK3Oyt87yl/h4kfAWMFskpxzWV/XGy+e6X81zbLLs6VS+M?=
 =?us-ascii?Q?NsOutFQuwnmpkn4rS16lC03qrE648qNfmGjH2p4IwajhLm+ykGmVSJ3WWszQ?=
 =?us-ascii?Q?21Xd+0tNNRLRMWYC1ooolfMkoV52Oi8hNwV2/dhmaalKp31PAeVdqTXRdiVw?=
 =?us-ascii?Q?ofuXOHb5/BHjBSa0XzbM0fj3GUGK8JOzSGorjm2L8glreS9U3/9arhQ8mzzN?=
 =?us-ascii?Q?iiCtic9NIUu0c9QZEeERZVtShCxEdoJw1zmw5hW4m5iybROnZDb1jV9jqwWf?=
 =?us-ascii?Q?J83mkF8Tspy8RwddCYuAFZS0zdbHvLnWdznU0/pipJS7Bfphi1rxhf8D1lPx?=
 =?us-ascii?Q?nIvYYRD56oGYCbo+WCAKCHrVnwOQq/ScL+2hwtyIm1hyTLYz0XimRzrjvytc?=
 =?us-ascii?Q?IBlFGnVRLk6EfbFYr0ADnCadnQ3ItwhDAg0ZG+1RGlYDCMyx8RHdtEb64OUC?=
 =?us-ascii?Q?OkgZO8pSrxLspsH+I5Rbi3o7JoABSSrsVKS8gavqMebkb99bFgqsfxIue1fy?=
 =?us-ascii?Q?dw8xIZu8+FyZhukBVzg54BTaRWSkJRjoK8CQqKI9YsdbdxzmOD97iOvRHqoM?=
 =?us-ascii?Q?Q4hy4uevEZDDG+DzKCMdyUo=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c835fa9c-6009-4f9d-1e6c-08dd7c719a88
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:02:32.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GrEqOox9gB5+4BpnbqLxbZZrOH+HfyLhBFsrO4uikqgh0rs1v50mxnIPiQqrtghVPt+H1cY13hvgmPVt5r4zuutx2X/Liu5K7k3/3D34smpLSfP/IUNeIEehM1KoIwu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6143


Hi Geert

> > sh_msiof_spi_probe() is using priv->dev everywhare,
> 
> everywhere

Grr, thank you for pointing it.

> > -       ret = devm_request_irq(&pdev->dev, i, sh_msiof_spi_irq, 0,
> > -                              dev_name(&pdev->dev), p);
> > +       ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);
> 
> Looks like you missed one instance ;-)

Because it can be 1 line now.

> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks


Thank you for your help !!

Best regards
---
Kuninori Morimoto

