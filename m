Return-Path: <linux-spi+bounces-11835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FCECB0875
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4CC7301BA88
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E192836A0;
	Tue,  9 Dec 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nDs4kljx"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A625B311;
	Tue,  9 Dec 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297112; cv=fail; b=s4NysSfVRhh8wtz4A3olUCjjmukdIxc7AO5SabCEVxkQRyMX2X3mbrzBitDsRtwcq1RADscZuPlnUm2Jtt61CwP67dcIruK0SIRZNBn+uqtIdHzxLnldJGGvDD6oaDr17FYt4w2i/G2akgv+9+nJaBhbZ+KPC5NOF6lmicsLgOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297112; c=relaxed/simple;
	bh=ff3kXGeaqRj/jR75jIsk4QK/HX+xN66F9ZROWBu6Apo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dOIc3y1tf0bQ0z8svibRbxR32nKVAEZ0KYh29ElOvexofEFYeAI5Vc9fuayZCuk/60uASnyT4WZIs3AnkO3KNFM1dAAWod8Vh4hLOu3tKZfAbbYmJY6I6wrSvWYOaoW+CZPc/7Dho4QZJOW3EA4Tdwbk28V9M8fcqZVKXI8o6OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nDs4kljx; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/jFzgk0xpX4cRp+p0IbpeQEbj2ncSl0mO3XDKGkKsk+c7hBVc8itnTFYD9lbEKOWyq+DYf4XrOJ/zxSjZiXh8EWOL4S6P81apxdfuICvYB/5z6djZEjFUt9S8+yXI2gYcKzvmj+p/FITNaHHFA6rP8gv/2OVx8VbscYwsfCOzja+OS0DFbhNu7AL+gEDq2z64oWyltVc11O683WJHqiBJ+hcFUSe7BUf9cWqRbF6lNoMW/7GWWwOtogCFKJWPBcShCnJQHdMsEfIYGWKZvCmXbq/NtNxa0GQWfvoswaMSBcoiefSE1sJoVZ11bTYxe5SuDMzZcQNMvNUmQXhQV7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjOTjLhdDAz6Ch2x/rMgmx8I/7mkk9P4z6R0pDzFw4k=;
 b=AsZVBck2teT0VZAGDJcpL5y1NejYxCbJjWmpxfJnyFRYzlZsRUOpZVNNslJJGX7oRcyh6NY1RGDr0cBqUZOloGb2CN4KCzPRYe7MkO9lziwUd56YkuZzmoVmlnqNSNjwnHqccr9vn7DMkIE6gSYF/XpxI9fkmmVmqe9e7EUagoumkqWiZmgX+zitIyDjnB6/i6LErb1hgn4DzsTcw3to8h3BElYlxfJSEDC8RmGArLZXB2U6f52OjQG7hxHBNSWtG92fTNuTEvyseXE/uuCW3xsITlhwA15RwjxuXAZS02wYkb/bxln1U61rSqG69zRedu530cxJaDFJOOV9pSBOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjOTjLhdDAz6Ch2x/rMgmx8I/7mkk9P4z6R0pDzFw4k=;
 b=nDs4kljxeVeK3dJ0BF0SaN02PHdjn2Bap4Ns2dmqaR+PnE649TfDLKMNBJk4QPp5kAQrWzubAtmqGASN4905WDgqP2rTs/GdP3hKKVId6iswPg+NLKGOKNJ+xsQJl1TNPWvGKxKU30yq4wrArdefzDIrg8lVYhAmVNDaaty9QiRLEXenHw64UGSK1tFgWiYi9PR0OpTP4vNCFEhhyQ7NY4FmO3KcN17aMmvZrSqVaF/kHxvsKtXR62pLL/oQ9OOdK9HVjAeKIG5XqDVb0PogzNWsFCSCki9W2Dh3gbxHUBCDS67O37XvNn6WBBbp7Ur4AazOur9M+OqQVZcnx76NEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 16:18:24 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 16:18:24 +0000
Date: Tue, 9 Dec 2025 11:18:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, daniel.baluta@nxp.com, andriy.shevchenko@intel.com,
	david.laight@runbox.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-ID: <aThLyQ2ZqEyL2tI6@lizhi-Precision-Tower-5810>
References: <20251209055634.3845602-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209055634.3845602-1-carlos.song@nxp.com>
X-ClientProxiedBy: PH8P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::7) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea82e8-d5d6-492d-06fe-08de373e93de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WikfZHYl86zzEptsAGhnnMjpW2A69vvUrTkxuYM16HXP8qI4FhvZvnzLRBuB?=
 =?us-ascii?Q?GvQ546nuc8DVM3HLze8i4LrhBu/81G76hj0vtjXsBd3EiSNzvN62+MgpprI/?=
 =?us-ascii?Q?S9pwyRZ2BoNoJo+mo1vGBuwzo2WTGEqWRS5B+erECFapLuaKjnNVsyxy+x3f?=
 =?us-ascii?Q?SS8wkLJ15LWUuuAcRJYIiWZxq80EGTRHvgOLnGXzTmxgCmzdusevutJri9hi?=
 =?us-ascii?Q?Ul9e98WALb85pbGxn9Wm6dYWc5OJZUu1Ety2NJnsmzfC/US1L5URtwhc4P98?=
 =?us-ascii?Q?CN9xcqRu5EBqKuLkQP2uEVc+Z/VYBRW5x2RveWTrVmsCMNaM1wYgSVDOweSX?=
 =?us-ascii?Q?X+gRMwcSrJPShT9aypWkdX04KVswwmJ2DC0prYfSYBywjjI1QwyphRxhwgRs?=
 =?us-ascii?Q?2ywO6TYOVJsHGunR31NVzWFA8gzPkq7VzCXTxk2KqJSY5Gyx4tQwe2vp4dQj?=
 =?us-ascii?Q?E5a1u+F+gWj3f9yH7UKStHozQvhDkT2IPBY2ApXHTPWGkzngnlTS/3yIjdv7?=
 =?us-ascii?Q?PY4VhQoAJjLwxH3lAiqoqE0/4owaZvsy44mxKJl8VBNid23DEcYjcm+xSac6?=
 =?us-ascii?Q?1N7iS9qRn4NYaf1mDOtR1SW8TDpjxcCYa4F3iW9r4gNgkQluZIHp0ad78qcy?=
 =?us-ascii?Q?FgZQzrOkzn8sgMElTxRepOomKmBdoxCDlEceoza/y6MMPFv4tnyE2knNfBLf?=
 =?us-ascii?Q?luAR1W7UqXH/BDJ6rnp0vXXhEP8D9TqtBOzxaZ2SBLAnO2ppOWLUfkukh6oB?=
 =?us-ascii?Q?9cKLFKqTGgoO94EY1V6Q9XksAHcaXH+dNDQZ5KQ5FeSOLgcKG2fnl37ifdsn?=
 =?us-ascii?Q?iK6BZn1l5K0wzFghwYEQwUKZHwJLoiXTWBy02cp2G4+tJHwAMQ5c36KoFPmO?=
 =?us-ascii?Q?XoolbuFhSQdQFjEA3xuhYCxJMYU3xgQRsdTSf1KOxPUnQ3xrzs+/aFlyBG7q?=
 =?us-ascii?Q?MK7bJDwdzWAQoDc/55mFPm2ygIAdNbTA22+42a3oOfJkTV+tO+lu25KAD8NC?=
 =?us-ascii?Q?DFuslPLFBKB4nylsU+J91ikuNYG59CWPYMSeaZGYFosGDD9mKjAB1dsfj2KI?=
 =?us-ascii?Q?gmhixFet9sl3TVJZbXPhvL2ox0GYgXlDJ4iQRUDe0lWG7ssj6EQu/JOpcm0q?=
 =?us-ascii?Q?/mggWowNL9receiRKp3ITP98aJh2nFxomklwE3huMyCLXQFcrHoQA1YeFurA?=
 =?us-ascii?Q?EeVQ7gOpaVgft86hdO6Qvma7FZzQTFYhrGLJsnbcGiWnrvBgw/l78bgSpzIV?=
 =?us-ascii?Q?6wkUMN2B3qPdR7gjgkWmFov3uj95xMPsrR5YwxeUfJ1gnkd9G5n81p0Vlgpv?=
 =?us-ascii?Q?/nex4ftDMis+t/xHrbBLYoMfj4cpX0rAVsSqzeRLFcP1gYsG94b+0gMEYBch?=
 =?us-ascii?Q?1grUG3VCKbofQAHZC0OVQAUfZXzmGQH3zj/fxuSwL+a+9PZ1t+gsDv0kJGKY?=
 =?us-ascii?Q?Q06vhwOmz1hizBtb1zr0FVHb3aoTTBYKzASN0qziFGGZpfzvfzpd83gzYwE/?=
 =?us-ascii?Q?mqxW0ri4zh5wnoOar+fSzoQU5EzsdzBlHVjC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coLpIddyODXsotDZLWtLrasPY6O5By6Sb9O7247wfb6S4df++G26n8aIKlpq?=
 =?us-ascii?Q?rwpWXkgPyr/bvcRyZJA6toegnzqJerpnu/R7kRw4eYe9+KF2qIzRd8J7zPSS?=
 =?us-ascii?Q?r+ixY9AYbJF+UOPId9HXG34RDsB9zb4iWhKq/rxKZTGxVvispp7R20XueVfb?=
 =?us-ascii?Q?GN86EoFeLyK/+21OdGyD79idC6svLSiWC6qiBCHthY5Oc8F6wnveV0NQld6v?=
 =?us-ascii?Q?QNQXpQSyBR+1KadeYA0ZvLLFwODy80hsrgAFoYMMs9KQYfa0P6O3IOG7XYgR?=
 =?us-ascii?Q?AkmPNWjbijWuKfpZWaJshfAiQn3yyNZ62rppQdg9ohA1YcP+sqdB0uNvx2TI?=
 =?us-ascii?Q?lBdBZgnw92GVootSFP0bMGJlXkA4GbkUQSspC6QkzX3xqq3DL9hqxm0orysC?=
 =?us-ascii?Q?LoGcMVGVRbO2m1AqFKZ5MweDpEKoMJBHVTcJ65nigi6KobmW3N+EWab5d210?=
 =?us-ascii?Q?lClmJ55PJubOSI9rQfeiAi3XRHsa9VmQVmxN4a9jlC5S5M6T4c4KWpeupoBe?=
 =?us-ascii?Q?dRVfCy9AQu8mUKAjfyJ+Qteqz6NX779J31PQsBr9oqx6CuVxDUy6Rz0eeR/C?=
 =?us-ascii?Q?QCxdU/R37kquGGumx3Qgv2qAb3MO3oAGtRYq8npEUA1B5WbKm4QGFpR8jOnA?=
 =?us-ascii?Q?JTylRFnkpXedKpMGNYQOcIUnFcjVgrBzYB/lEj1EYnT2C6SIK3ptdf9+7Ds+?=
 =?us-ascii?Q?b0BMBlOQLQ0oRo11x+8Qz+bpnxaC6EyDoKUZkjH2foZWQXacy6lwWxu5tFKZ?=
 =?us-ascii?Q?ivTnXQF4tL09RH2uzAkjMb2m8VEO6GakRd1RPIrsHbfpR96Og7xnTJLSAHXW?=
 =?us-ascii?Q?6wPOmzDP06PZIV6uFkIHHY8qqWs2EItbeRO+Zy3OnC6JpdUL6WE+wMqkV3bK?=
 =?us-ascii?Q?KLBOa920gsIieOmnIFH/SgV193kiG3MnAFok5E801nZTk4etU8ssCNsETEeV?=
 =?us-ascii?Q?YuY+t9gyMzPpKGbOQmj0jJvU6PY5KPnfdElVC21zGbHpiFKtF9RwEKnxwmVJ?=
 =?us-ascii?Q?qQddZ77LhXQ48HnUfMjX39GqXDsbAbSyar5EcIFRakvuYJDfQonulzbuuAb/?=
 =?us-ascii?Q?njNSFC/UqMYOyzCIIo4u1ER1jHUBrVKb/yLW8e3L7akx6T8suRYl1LJ00B0l?=
 =?us-ascii?Q?LVr7nejGHgtBw+rXrT1ndizr/yz7wP5+UkzMNvly66679JIEdjiUO/iEYgOa?=
 =?us-ascii?Q?/GhPYL2IsPqiU8693qgsYnF1b7aXbquiKWIt0jHcb6nY9NMGfCB1HIiQaAim?=
 =?us-ascii?Q?7JYfCmNqaq/wJaMBQjVbyBrNK7awN7RXdFT740xdXK3agUBGyO0Ea5UedcBp?=
 =?us-ascii?Q?aVROz6NT+bjJ0yNFzvv4Lc4rTZr94gKzB1HiYhanfRd/+5XCkwAjCk/grwrk?=
 =?us-ascii?Q?iCpUFP857nQhTBAkOiyEUqx2Now30eXcYnjS2XFH4p8n+InvS9nw5uQZxnni?=
 =?us-ascii?Q?UqClHyMzkO4ytnpvovgOBgRgkSC+tmlRoDGZz/MzVX6d1yuXks/orVgkN4aj?=
 =?us-ascii?Q?zk+EGpFs0+ivM4QZIZCV+wP9DZqOWsh6S6sjiebg0NrQh7U563SEK7bmntSU?=
 =?us-ascii?Q?ygPigLlFqin8sdvfyU76z8cfpt99SaSUfo2vx6yx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea82e8-d5d6-492d-06fe-08de373e93de
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 16:18:24.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IiDMCVoL11Dh5W8xcLUvAY3CYOMnzyzFNDNWV7wlx3MuYL7cSPjmpa2PxkomLI4dq9kRUWK+p62JE11s2KvjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827

On Tue, Dec 09, 2025 at 01:56:34PM +0800, Carlos Song wrote:
> Convert min_t() to simple min() for better readability.
>

Ref below thread.
https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmail.com/

at least need summary some important information here even it is simple
change.

Frank

> Fixes: 9f0c21bac5a8 ("spi: spi-fsl-lpspi: fix watermark truncation caused by type cast")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 065456aba2ae..01c674d466ed 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -489,12 +489,9 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  	/*
>  	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
>  	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> -	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> -	 * for min_t() to avoid truncation.
> +	 * it caused wrong watermark set. Simple min() helps to do type cast.
>  	 */
> -	fsl_lpspi->watermark = min_t(unsigned int,
> -				     fsl_lpspi->txfifosize,
> -				     t->len);
> +	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
>
>  	if (fsl_lpspi_can_dma(controller, spi, t))
>  		fsl_lpspi->usedma = true;
> --
> 2.34.1
>

