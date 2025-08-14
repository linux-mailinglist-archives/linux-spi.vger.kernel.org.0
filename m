Return-Path: <linux-spi+bounces-9432-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F560B26CEB
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A049E1882250
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6751E3DDB;
	Thu, 14 Aug 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WyMt02ob"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C649166F1A;
	Thu, 14 Aug 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190176; cv=fail; b=q7dBen8MTAsh+gVQzBci79fM2HTfpZUESQZKfRFva+i5+95QQd56z2FiQaQORaRhNKGDJBK7k5VsohlR4tvsyRgDDe2jDH/Nc3QJ3h0uBlQztrz8w+nrgShUZtd2KbucWueCbx4pHb45UpONjVnZlM+zEt5D1Z1GJ6ooMpOykP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190176; c=relaxed/simple;
	bh=cDMeBKYq3449zVp5+biP/QgdTDAXyYBWoaKpQJ6fEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZtERe2MHitNk+MpEb6DDBPNfnDdffOQj5QFlqHifNuFi4J5LjmOKaIahTnDE6y4KSLXlA2fyKaGsbqmxULWVdFQZ+V3+oxvpWAGB36BZre9zsEBJrLljKIRwcEHZIg1AAFZav8ZJ845sv8o9gPYQ640Ncg/SN76YwMp/yf5438=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WyMt02ob; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrdDgzRhNzJ9+MEjtE4RU3TUzT/K4YiF1bweWaIBtjb/CTrCYFaW1grkOYIYXzOQOurbYH6OZY/nZiipw5v5lYn+z4wvcE05jhEzpoW4VZhMeCxAFmi3JDt+Lwa2kgnADPCbDiobdJacL/C0pLoVExJwTB0CP9K6EgrxKNMdFGRiAuyTDl/Ry4xNZQ+iXWf6FOnmZHBiFJqaHEm81qqaMZsu81wywSePvPzVvOKdzs2aJDda5ybP+4KJ5uEFutC7Yjpa0098oyIgak2VmCySwVRWypEzH63eyQYmiMSItzlkpxW82UYUozV0EFJ31PMWJPlQ1wzo9PRmbzDPvaSkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57/wOk+NL1Mf/iEyS189Y8eN65s3WMe1hJRxQ3bDB20=;
 b=f5/CpGTUULL2eAilQbavXXOcLmDBrKbcW6uL2jcWaS2raPn/pdfzJKEK35mNnWYmJbE38zLPFz0MMYLM8dSwpoSVfoLrXZBv0ayBDB3ESJwCLAbUMMmrHLLu48hgPw4apCIUQ8j8r/ZsNU/7/atbZhbgdU837iAToKKi0rb/uN3J4RQzQof0CpauZPKVyJE/Ahh2haX4N/WwBYKw8fbSJJ6SVw9cuSlTwszcHESTcoxQZQ1swhf4E2kT4QNV12aQHJH+mx2nry07Dn6izzv3BrNhWtzM8isGrP719kVjpEvDESxTGn+rZqyGnFBeTXdoG4YgXOCXzxmo/grRiIaW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57/wOk+NL1Mf/iEyS189Y8eN65s3WMe1hJRxQ3bDB20=;
 b=WyMt02ob36FcPBVGr5N4IuMMeITixT8mjCVBIDLKueHRpoed7uN6WO1eB7IWFpXR3P18aGu7a8+38HpZNGfelxQvgfP5Ix6dB4IayqBQuyugJfHDa/Y8Lt3S+bEWNZIF48h+tnn88lpRhGFQTF7EjbT2NE+KRYNN53eTFVrn2jtmlz4ZyRfaYxzCgBxG0rWMZkO+NJa0XnJHZv/dQIlOKz9bYZ+jScLVrsUjoK+fcNrrlBGkVNiNminAG4G7rW9VokmivR7NSeqkVluxj6wSTUrR8o5gqn5ByvfduUOju+zannTkyIuzdLk5+FCLxx5nA9ipCV9zLk4uuzV0VSJJXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU6PR04MB11208.eurprd04.prod.outlook.com (2603:10a6:10:5c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 16:49:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:49:29 +0000
Date: Thu, 14 Aug 2025 12:49:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
Message-ID: <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH8P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU6PR04MB11208:EE_
X-MS-Office365-Filtering-Correlation-Id: cae16560-ea47-473c-8198-08dddb5288fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3PZkvG1giDeimZ1sbNheLiKTZPlPe3ckyNresOQZl0h/pIRg6eW63E0Q9oK?=
 =?us-ascii?Q?gqcecN+LTdfWxvexaudujez8jqCUtVq0Fc0LcJXcp0Oisk/iODXj6VUU3N1C?=
 =?us-ascii?Q?67zvtxC4fqjGZL13UcebyCVB8OkRJFmT7Ltli3FiqBDhCjx51ohDDwaDynRr?=
 =?us-ascii?Q?oNR/xYsAnjMdZ83ipJj9jcfhrOpZaVv4sTL437T671NuIw/VC+bmEYvRhKg1?=
 =?us-ascii?Q?aWKYNhXE6QlkoSVgVw47f/OQ/b7xSqskw/aae0f8Zw/++oLDD9yT657/hGR2?=
 =?us-ascii?Q?TCHelmzEJwINRxZUJEZDvDjgWWcBPxAd9twn3Tiktr5IRj3ZflbLCEhdqtfa?=
 =?us-ascii?Q?ciPOTRPPAiR6X22y3PaShrlJ2WazQxxQWabKpKt82IkVSVYkDG9PoQUXeu0j?=
 =?us-ascii?Q?P81ByxhoT59vDzA7srV2BZrSmR7Md+InQtJxXWNHImNKMqHBqwF4SdgPBQmP?=
 =?us-ascii?Q?BPdXpr6PYY/sffA4+PAqCF6bmz6olk1gRWhc3dykMX/7N3ARorkP1dhqzcE5?=
 =?us-ascii?Q?HQ2CJR6ZeB0XiQcuPp9Zjad93oQyW2jBtlfz5s7G2f6H9lOBH7LOI2+/o1tt?=
 =?us-ascii?Q?MTVFQyythnbcDa4Pbv1R6e8yTgPYaPA89qDdW+cuz9T8/PQM+VS6r7ZJplD8?=
 =?us-ascii?Q?00O3eIaSlh5Iw4gk41OR+y+S9fejnLjHRpbDvlRKsMdWBXxLhRmFzqlR84St?=
 =?us-ascii?Q?aOzuqw9IPPoE7e7KC7z8/gzGlq/7WQ9UWM++bGwHSX+Wr2QkW6masiv/f0lA?=
 =?us-ascii?Q?m9JGx7HADhlnCSV0H/I+ifGH0dk/HOUmnGNXa8mlZefLpByIoPjOS8mdQ53D?=
 =?us-ascii?Q?mJ+o8WcWIfkZXc/X8O4OeRCzJIW6v6KWuIspsi+ai5jHv4iKTtjc4PvZ6mMT?=
 =?us-ascii?Q?sNJ8/83X67heX2f+Z03BmoS7KZbmnvX5iVN7q7z1cubrS+2U8uUrvFgcujQy?=
 =?us-ascii?Q?C5QTOcqI/zqT2CE0culppXVagBM6dPREQ987G9AlgROsIyd2xRIEwZmPrKNf?=
 =?us-ascii?Q?GTUQZ65Qzn0fuijIKPwEfC3C8iVoexVH5qHlXJPOejNG8hAH+tMy4/Laik6i?=
 =?us-ascii?Q?uDEX85jO2X6zGmqi7DM1vhz67Wz6834+MoiaL2Bxe4kdTXLunol1PfdmWpvp?=
 =?us-ascii?Q?XP1Vb4hrxeYoDUoA7hzP3qEAUeNUIFMfqYFGTK8RBEuFDuE364zjWb6pDBM5?=
 =?us-ascii?Q?jwMY5xenVdB/FmmU1iMoa6INJH3gAJte/8KDqtLKidQ07frHbXg+vnNgQ7BD?=
 =?us-ascii?Q?QwxRf6xUaYnQ7AtArm0vtBiM7Wa85MfT1lgICfVGGhYjpGlGrheGvKDjiXJm?=
 =?us-ascii?Q?CXq+ZNCVlYP9ZUk0Z9sQ7yrahSvcH1oE4wADm/FHAs0NBAjSLOHsRDMPzhD0?=
 =?us-ascii?Q?5+usGisf1Ko5KzK3v8aBnKuFcAPo215J2azIa7IH8X5q7Kh/ZvjcDqB5viFE?=
 =?us-ascii?Q?K35WjdO4XzCcFp37Ti8FZGS6Mq6Wi0TeCdZOdfYOIIQ+ce6DiLokPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0Syfyqp+PLkXJI5R39BWn5Q7YY7YCbYQVvIC5hu6zothc/tlpwZ8oVVrXEw?=
 =?us-ascii?Q?NM+1nnkoYhATz3U2K5nicAgrm+nOU7GtkDm5ku9A/uZME5SBnQKAzBlGD6Pb?=
 =?us-ascii?Q?8aOJd0jVivRrGCdqzdPfjSym9wOK4eolUOuTddZqi4Mtp9iiDefvPJpFQ9fd?=
 =?us-ascii?Q?4tdqiJPbMdPf6faf/1FN/WYwwvwPSzuSbopLB5LJL00s4oZjTmHWGEkN4oLs?=
 =?us-ascii?Q?CAtn7zAwsIUeR0LuiGSsgp18oZoey83QLwqpJ7HqpPEjQ8rGkuXaIw11/wTB?=
 =?us-ascii?Q?zibQMgG0ukq6AfNHE50a4QWQVqADk6Ixma3oP9aMKmOWH5JBTI/IxSAeOVCx?=
 =?us-ascii?Q?Ixr7WEKm2QtFuc5IeCFolzThUpmXUJz1VuuU4sZRJwpYjkgRtrr56HR2twSF?=
 =?us-ascii?Q?kiv2X7VQGN0IUKOZ13tpoCw3mXdYh74XATWOXdy7lD+liiCd15iUj5cuZyp8?=
 =?us-ascii?Q?zIQ+mFyBMXnz5cqSZ40tStY4Hei9cl/ZxRwp8gRaQPkDeu/EOIvBE7Aud8wn?=
 =?us-ascii?Q?S8/dWk6r8xcxG7B7+N3lMkUyGC7koI3e9xKqIIKDL+wbRc9oGESuJ7Wmi3a8?=
 =?us-ascii?Q?dIFeB0ugsIIJieUFfCU4S2Tuu3HQXI8QyifGX56GsvMraWoXx8e/hOvRAgo+?=
 =?us-ascii?Q?Yto1OCvTSALv87WO8Kac8bDH/diiK1GzoqLz8kVyqUadLSvszQRTscnEANa2?=
 =?us-ascii?Q?bDw1rtnq6jQfLmCFnxA0LNAV448cDbQ2VxU6O3c8QpOk4sc7FZykrlez9lPR?=
 =?us-ascii?Q?HOGSLdORHGu17ujITfaIhgx5aFnyjF7b9uCmOIkmcWY/LP6X13plzkviuuKV?=
 =?us-ascii?Q?AIxBPRBYLAGO7b/joz8hzbcVNjuHaH3BoYqf5zAlKJI4KlYaGzKdjmQ/EhD2?=
 =?us-ascii?Q?U96NNAwJjgL2ySHFLiL7Xn6nTVM5mMncTvNvYZnmgKahI0ZyFEMQX+LIdNe8?=
 =?us-ascii?Q?5yo43eysYJ6KdnsDEn70E+z4vMepdeqK6TL6WMcYrNJM9A5ePF04okcMNyrc?=
 =?us-ascii?Q?qgdeILHFlxKqXXatiZCYJqvyUMpQB8q5mtVmcq2aknqYe6HsvcC3kGdzjx9A?=
 =?us-ascii?Q?4aIgy3lkr5B+R3EiXle/nJWAxX7/3pRU7D4fp6iOmBj80cUBwMXl9sbLBaHC?=
 =?us-ascii?Q?ndwz14ZXBehdawswUCAFBQ1pPBIL6K3uK9ArfStJzhLdvRfRSomhTydMePTP?=
 =?us-ascii?Q?+9G9FzneVWvvXjJa/NJqMcEXfdSdnRREN8F5dfIjNpgYUSvzcstTPKO00oPo?=
 =?us-ascii?Q?kj6iMA/0ZDVNB51iIKpp0PwuaWdDWEfX/z8i8ZUaMWl26K0UzhZxIv1rYJGS?=
 =?us-ascii?Q?ANnWGNbiU9xBhozbVXptd9dO0YrTedElgatwkbBEVPrrxaJzUYxDZY7TRErR?=
 =?us-ascii?Q?FhGf0BJd4BvRw7CAc83HXHmR3Y0EAeDEEnpDXGMdk24GWNr6lsSfKmCqcQPS?=
 =?us-ascii?Q?w+R0Cnx6sCLDTpwsNfSOTzTA5L3IrbK2A26xI/eZAZkMEEDVp4GlKPM/PtjF?=
 =?us-ascii?Q?X8MwrNN/bka43B/6uj673y4ALOA0wTIivmoOfs4jEGhJEKReBgwYE/rrrUGd?=
 =?us-ascii?Q?p59934c9xSvF+YBBHRE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae16560-ea47-473c-8198-08dddb5288fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:49:29.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYB8U+N2hKLkn+i2bNjlIOtdrggrGYoHBsQQP75gom9dmliI9WdfuYuAshaxVpzJ6ySA9HHlqkvhxvHmerDa5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11208

On Thu, Aug 14, 2025 at 05:06:42PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> The driver currently supports multiple chip-selects, but only sets the
> polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
> the desired chip-select.
>
> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index d44a23f7d6c1..c65eb6d31ee7 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -70,7 +70,7 @@
>  #define DER_TDDE	BIT(0)
>  #define CFGR1_PCSCFG	BIT(27)
>  #define CFGR1_PINCFG	(BIT(24)|BIT(25))
> -#define CFGR1_PCSPOL	BIT(8)
> +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>  #define CFGR1_NOSTALL	BIT(3)
>  #define CFGR1_HOST	BIT(0)
>  #define FSR_TXCOUNT	(0xFF)
> @@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>  	else
>  		temp = CFGR1_PINCFG;
>  	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
> -		temp |= CFGR1_PCSPOL;
> +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
> +				   BIT(fsl_lpspi->config.chip_select));
> +

Feel like FILED_PREP(..., BIT()) is stranged.

I suggest #define CFGR1_PCSPOL(x) BIT((x) + 8)

Frank

>  	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
>
>  	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
>
> --
> 2.34.1
>

