Return-Path: <linux-spi+bounces-8741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18726AE6C56
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB13BBC7C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999B202C46;
	Tue, 24 Jun 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O5SRqsOG"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012055.outbound.protection.outlook.com [52.101.71.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2F202F65;
	Tue, 24 Jun 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781923; cv=fail; b=k/wTP9eB+qwWGDa26yUzx6iFPadoCQlKAp5tJaw8K+PYw+3xgXlWRh/Vu85h82xF8WiUjWJhmDGV8z0rVjcVnG2tHzNFRgZ47gDnfAJP84hB3mXPrt/QqGFYLOjOjprBoxm+KmF/R4wCtUyO4QJlGN4fDJTto6ku1hu7FAbtK5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781923; c=relaxed/simple;
	bh=mFVHipkgGxnK1cyAdQQr03yU/wt0zv/5EPigs25/BYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gHifrApxUeU+XRUDqqel8roYxZPUF4TYe4hJ1EdQUC4S8VZL26Dy5xPiR17rXSUv+3mTnWT6LeUnzC5b9AY5aTx/L0Eyn9OgFqxAZZVvx54haHgmN8404KohTFW7z6nhDYnDWuidSW/TZkQAYSvks/+mHq0JNWLNQyu9kAFwWb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O5SRqsOG; arc=fail smtp.client-ip=52.101.71.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZmyyi6v4EBGUMk5OyOQcH+Mi/VO1TStzuP3qoFI37AmKqrwVJrkQElNprL4jWJZZ2oU/1jR6sTR+aFmS8N4bfA0yXQjz0Ip+NwnZH2cHp7PH0O6xs7iwYtuFC6KZ8Vl9Vf0XF7n2hwLO/n1mgbr9IWBeE50t4bRnLuLVUI7LobXSZf3ogUZmpvzcwMofexPUJVvM0CWLEfxnsHBbwFhcbjBgHGqP7ufqviingNK9RHw4KbseC4ZzhXTiX44HCh7UVo1hSirfQ8LGvLZv/fDt3A/oTucwl6qrpbYzCknHYu9V1i/OG6v1Ax6eaBN9W3+9Ua8/NDFsw/4q3mjXmVfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77uIwXF5ohgIw915sUbs2d5cdKACvctmaKeQ3PbLKIM=;
 b=owS5SNa79AUczgT+QkdyI6xQ18gLD7BcXblGLyCCgzxAa7mKYON6mMytADhjyF49BHOCyesROwsGfVWJDOcbA/nNAqK0ntRy0tasbDSYZDoLO/eQoJKNZcb/aLS/ZlynufMyg77WVNsxjhBZ+xE/C93tteNwtn4X1aJKerIA/Nr9vsmaOEWEOFdeuIDEgGM9lRfvmant6lcpjWpyDCtYJIlyHyLBIWpHrBiS+cAd3nDV+cPdGTdh9nDecXjf9/KBwmaWbL6UCb0/xyHd/tpHEZcr7Qh51egwCVh20RAcQmQ70CTMKenWgPZOrcH06s56lb8d3XDAKz1lUNtC7Qrqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77uIwXF5ohgIw915sUbs2d5cdKACvctmaKeQ3PbLKIM=;
 b=O5SRqsOG+8xK8tcXhQov+PFwnwtIMy5Ciesd2Tc+Wv0003PP01T4oGrcJHj6h6LC0ylUswhzbmD+ytjfz3eatxdzYNaZ1wuhZkY5mTIUi+97AmYb3sUunlZ26f5ZmVvynFnlFUEVt7V7EvR68eEDx92vpOqlsfeejH5lqQa/fR9rnuln7G/oyM3qAQxGPgy9KDBBE1MaMXFu6yOePKCkcIi2M42RibKBhLrMZurxBDIVuRqKY7WifmtkL+9R9NCnHDK9zYkz4LfKLLn8BZ0ZCtMb3c+ipu+3Ce0RoTd2MtugWBpFepxkzDtheptUoHSSq7fib7dwFZxH+hQo3gIaYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by OSKPR04MB11413.eurprd04.prod.outlook.com (2603:10a6:e10:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 16:18:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 16:18:38 +0000
Date: Tue, 24 Jun 2025 12:18:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Message-ID: <aFrP1ZNvjHCPmbWG@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-2-e7d574f5f62c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-2-e7d574f5f62c@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|OSKPR04MB11413:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e28979-971a-4c9e-ab3f-08ddb33ac6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTSv8YTgv0MiGoR75DzokrzbGJpacAMR2coa+cghA7ArhuR2JmPKNXw0xvxC?=
 =?us-ascii?Q?K0qRPZYimLNwzN/G1QsTEtKKqcq61SYB3HIAtJ5CVao/dUlx79lFu6arb5i7?=
 =?us-ascii?Q?m3I/8ZYGbSCpdWqvq2kGIzzHcAlHcAcPhHj8f8iEZRggKrl2I1o+xpay7FtR?=
 =?us-ascii?Q?9ooER0N7dGIuDsIbNaOebrS333lLVq+tMr1BQE0F32AeSLyYcgRcM8ZgmKa6?=
 =?us-ascii?Q?8BUccz08uFVrlTtq3P917bsdVl2gpRMvU3u+7W/y8/W/iwqzjjFqm/K5YGe6?=
 =?us-ascii?Q?H8eFMfhjb81KHevvoFuMPgpZ8n3788H5K3tI085dZyyzaXYPj9sXVyBSPHhB?=
 =?us-ascii?Q?lFp9lkbjsgjoMRpFkjwIG183AAhvH+NU5CKuhLF11rmKmpbX5j5bsV183Hfp?=
 =?us-ascii?Q?ywDBzNt+F/VE6Dw9vryavEB1F8atZT81btHi22QJx1SBdsrIBE2xX+PmMI8u?=
 =?us-ascii?Q?C5eo6QZOoWs7yBhT/wPCZNzErCV1cnwnZxuCok61KdofnXSZ8QdxtvuGBLX4?=
 =?us-ascii?Q?qIr2RXbDcDCuUAt73UWJEk5TPf47QlYnEzKSN/v0uhDqhlVyRq3NZssaon/q?=
 =?us-ascii?Q?W8UhSmvUeu7FljbPW8XZ4qx6Aybay7eTWNQMQAwTpxd4Q1ccwsDtK76jPUu/?=
 =?us-ascii?Q?nC+hStSSGWSbhht8kv5X20x8u/OGPL1zvpXfvr54Y1ljkuxkqsoXwJws+1cm?=
 =?us-ascii?Q?gPVl9sNmnzpaBN3QdhgAe4Sx3vs1xpScPyZnN6+EbaTOsIpaSysE0LPwt6Gc?=
 =?us-ascii?Q?wpuRccf3mVhuDrLkTXa98lwmET3+Ewc0hD9E3P/rRH0Rrwb4nnsJ9mI8r7kl?=
 =?us-ascii?Q?csRn0z2QRBKAflH0/gba2tfjhQzAIN1osaHScA8p3KTaIH6bmoluDLh9xOM0?=
 =?us-ascii?Q?OJlrLbqGEXEphiohkFbSPNkTYVw1N2L28IiiqXxCLJcZI4HZDt4UGDhb45T6?=
 =?us-ascii?Q?n9cMmxe0srxw0EYL934uTuK8E7n6vp/lHf40i99bXPyi7JnttIHzHkGVp7z6?=
 =?us-ascii?Q?+EORyuIzJHkjjwkX3kBhpsBhJIBRdHy3b/ksvAmr7NlyQ+LPJJSkeR48VZGG?=
 =?us-ascii?Q?gfIP6D9Ok5FszANnwafwv9ouvUZobXJDLBPkVSG4ahMHmhNR+RsRUNaBZkch?=
 =?us-ascii?Q?2kzjO47TFyR24+xrvU9zPo3lkSld1Gf98eD9qCW1kY/LuIRNUba8s5AGr7QO?=
 =?us-ascii?Q?qXz6GITWFn61nJVgjNb41OlUqTm7pb8Vawv9PPDjvZVTn0FHkfnHn/TTj+v/?=
 =?us-ascii?Q?cm3MLXWRKEnn2S08JumlGnEy+y2XE5qyaSSo7c3JuVd00eaDhn2ENru/3wN5?=
 =?us-ascii?Q?kk4j+AT5j0qBbCQarl/8KBd84QalGJ3Uh1clzJCho3alzun+wHV3z1P4ddQr?=
 =?us-ascii?Q?TxbdgOgJZZTlOj3TCwdegz2lPZvXkNOeQjq14TFA01LkSc7Fdtrkg5TCALJI?=
 =?us-ascii?Q?fcELv7coUX6/fAbygRQNEeQTVBqmFH4qqlxxyvwWqt0EG4cGqyr/cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lc9tcrABSKsvMt231TdI8mKeU2xIeTijGO9pZgrLc1kelGYZt0eF11uIcmHu?=
 =?us-ascii?Q?QeqffDAyYJdKeJtVr2NDZDwmRKAeIAIIHcd8Glkv/z87ZprUAezPC2X0TmXZ?=
 =?us-ascii?Q?DFOOcyd6bWuhD3vvEDMZ2kqsrRSzR9kEChdqntgKues9so3Sv5LQ9/b3K3yo?=
 =?us-ascii?Q?KjPzXJ3gfQYMCMZhqtRr7+qmWh2czVOaDOCcJ90BHN6OJHufZsgUFf7FkCwc?=
 =?us-ascii?Q?WJFvBFPmAixm0gfmM4wH/W7A+5qfCW4hYMpR6Fs6o9WZeDLCXEAOHj1QfMhH?=
 =?us-ascii?Q?QSt+DEKuXEoiubNtldCPCYDx5gIzqGVaU+V5TqZLlBOko3H2I9qcGXoHR612?=
 =?us-ascii?Q?GUHtStTBJHelRoSE8zxrbnTyZoZ2/xUqPmHO6HXMlAV5WkWL2vcBQfwhsZFo?=
 =?us-ascii?Q?jG2/GnJ4w0ROgb40Z53xYNbNxN/aGYHf+L3FQkpT0cjb9F2jbXAkMNEKXd4C?=
 =?us-ascii?Q?9dRLTHIHmktk71TWiDKBFJpACRB9Dd1gHkm+ZwwBgNtEubCegD4oiscnH/Yg?=
 =?us-ascii?Q?gA3BxNyuh92xsW8xOD/sAvZMYQpjExAiZmtvX2kyqizGRJbGIlqP4g9UWRvz?=
 =?us-ascii?Q?9OUjNLEWNTxf1I4g4d8ncaOYnOdSgTpKA1Yf4192BOevMQHWNu4WqZq/bonc?=
 =?us-ascii?Q?VxAuwgwd6eznIBLlaW8kXWbpXTImPIoAls8MjFY4HZAmU0fv1LUAThdr1tlM?=
 =?us-ascii?Q?zcckgq9I3hPt4oV8SdW4WJ1NqOE0wXIOyTmig3S2UP597s+D6akGM1B55Hes?=
 =?us-ascii?Q?9d4T70S2aXqeMzmDDc2uBy27SG/7zK/Waljn+g8QbkYjD3IsrKcGBDLIXfi9?=
 =?us-ascii?Q?jrskhShtEYUBF8Ky3wHv4BrQ2+sfy40AVbV03uuZ+BlknbrgNslBnmP9ojvF?=
 =?us-ascii?Q?nojgq3qPck3vCHnq/rWg5CyhCYBLMwyblLxc4hhRkF1XfhBa+I8SYZ4h3UOG?=
 =?us-ascii?Q?d8c+4zG3/66mxxv2RggSnv5kOw4oezijGQgrCyo0hMnHs86nJD7QWlaJ3NhC?=
 =?us-ascii?Q?relSb9KE2uwYauhqOVV+5qLeXc+SJLvoJ2OZPLzZvBEts7JlAj5VQ8zq6Sg4?=
 =?us-ascii?Q?COZSVcUp+6ImTDr2vGdWI7PnW62N/y+6nzc5QZriKcwDqrow2k7dFPm3QIl3?=
 =?us-ascii?Q?wLNmHhZqwxJoFYpcXsSYKzMo7Y9E+Av6HTKn+qB3/JvM3cliu8vzKuakaJ9E?=
 =?us-ascii?Q?VNC6yyOrZ28FDy4lP4eIcUMR7c+MXuan5M0yB9XeQtRdkGKA7bGasry+IA9t?=
 =?us-ascii?Q?2UC6GmZ4TTygoNc/M2wkDvwiCQrY+0UPFzdApQQjc2N/5qoRxhQNJsfurwi0?=
 =?us-ascii?Q?HcTHtNDjKQcY1h4B7v9HAGfCZj6PE/SHwoknUkv8Gg0ey/8+VdlcVHhUsMBt?=
 =?us-ascii?Q?mGVIG/ufwO/Y6//HwutsmwYwL7hcTxjUTROiWmNLheUSx9gpJdvFKRXWCjl6?=
 =?us-ascii?Q?sm2mp0TK/2Zw+UoiTRNvsOKlscqNgP7MOXrxRbBIouRFvEEAVqRpYxFH4Ugy?=
 =?us-ascii?Q?Rbn4fuQjoV+y1UcTa7u0/7at2R4vRKoNlZo9xmfeNQKOxxTwrQMqCzB2+CWZ?=
 =?us-ascii?Q?g4FKWXKX6WWNguea42c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e28979-971a-4c9e-ab3f-08ddb33ac6e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:18:38.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKFEoobZHlW9TdNKGuUTXrsBLb43MHnEtHmgQRZlXGHJt4nWxFvSEnNIrsyrlj2FHdl+53k0tfej6ZNdJIO2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11413

On Tue, Jun 24, 2025 at 11:35:32AM +0100, James Clark wrote:
> This will allow us to return a status from the interrupt handler in a
> later commit and avoids copying it at the end of
> dspi_transfer_one_message(). For consistency make polling and DMA modes
> use the same mechanism.
>
> Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
> this isn't actually a status that was ever returned to the core layer
> but some internal state. Wherever that was used we can look at dspi->len
> instead.
>
> No functional changes intended.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 68 ++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 744dfc561db2..feb29bb92a77 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -591,11 +591,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>
>  static void dspi_setup_accel(struct fsl_dspi *dspi);
>
> -static int dspi_dma_xfer(struct fsl_dspi *dspi)
> +static void dspi_dma_xfer(struct fsl_dspi *dspi)
>  {
>  	struct spi_message *message = dspi->cur_msg;
>  	struct device *dev = &dspi->pdev->dev;
> -	int ret = 0;
>
>  	/*
>  	 * dspi->len gets decremented by dspi_pop_tx_pushr in
> @@ -612,14 +611,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
>  		message->actual_length += dspi->words_in_flight *
>  					  dspi->oper_word_size;
>
> -		ret = dspi_next_xfer_dma_submit(dspi);
> -		if (ret) {
> +		message->status = dspi_next_xfer_dma_submit(dspi);
> +		if (message->status) {
>  			dev_err(dev, "DMA transfer failed\n");
>  			break;
>  		}
>  	}
> -
> -	return ret;
>  }
>
>  static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
> @@ -986,36 +983,40 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
>  				dspi->progress, !dspi->irq);
>  }
>
> -static int dspi_rxtx(struct fsl_dspi *dspi)
> +static void dspi_rxtx(struct fsl_dspi *dspi)
>  {
>  	dspi_fifo_read(dspi);
>
>  	if (!dspi->len)
>  		/* Success! */
> -		return 0;
> +		return;
>
>  	dspi_fifo_write(dspi);
> -
> -	return -EINPROGRESS;
>  }
>
> -static int dspi_poll(struct fsl_dspi *dspi)
> +static void dspi_poll(struct fsl_dspi *dspi)
>  {
>  	int tries = 1000;
>  	u32 spi_sr;
>
> -	do {
> -		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> -		regmap_write(dspi->regmap, SPI_SR, spi_sr);
> +	while (dspi->len) {

Preivous have not checked dspi->len.

Not sure if it is logical equivalence

> +		do {
> +			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> +			regmap_write(dspi->regmap, SPI_SR, spi_sr);
>
> -		if (spi_sr & SPI_SR_CMDTCF)
> -			break;
> -	} while (--tries);
> +			if (spi_sr & SPI_SR_CMDTCF)
> +				break;
> +		} while (--tries);
>
> -	if (!tries)
> -		return -ETIMEDOUT;
> +		if (!tries) {
> +			dspi->cur_msg->status = -ETIMEDOUT;
> +			return;
> +		}
>
> -	return dspi_rxtx(dspi);
> +		dspi_rxtx(dspi);
> +	}
> +
> +	dspi->cur_msg->status = 0;
>  }
>
>  static irqreturn_t dspi_interrupt(int irq, void *dev_id)
> @@ -1029,8 +1030,13 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  	if (!(spi_sr & SPI_SR_CMDTCF))
>  		return IRQ_NONE;
>
> -	if (dspi_rxtx(dspi) == 0)
> +	dspi_rxtx(dspi);
> +
> +	if (!dspi->len) {
> +		if (dspi->cur_msg)
> +			WRITE_ONCE(dspi->cur_msg->status, 0);
>  		complete(&dspi->xfer_done);
> +	}
>
>  	return IRQ_HANDLED;
>  }
> @@ -1060,7 +1066,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  	struct spi_device *spi = message->spi;
>  	struct spi_transfer *transfer;
>  	bool cs = false;
> -	int status = 0;
>  	u32 val = 0;
>  	bool cs_change = false;
>
> @@ -1120,7 +1125,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  				       dspi->progress, !dspi->irq);
>
>  		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
> -			status = dspi_dma_xfer(dspi);
> +			dspi_dma_xfer(dspi);
>  		} else {
>  			/*
>  			 * Reset completion counter to clear any extra
> @@ -1133,15 +1138,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>
>  			dspi_fifo_write(dspi);
>
> -			if (dspi->irq) {
> +			if (dspi->irq)
>  				wait_for_completion(&dspi->xfer_done);
> -			} else {
> -				do {
> -					status = dspi_poll(dspi);
> -				} while (status == -EINPROGRESS);
> -			}
> +			else
> +				dspi_poll(dspi);
>  		}
> -		if (status)
> +		if (READ_ONCE(message->status))

Why need READ_ONCE()? Does any hardware (DMA) set status?

where update message->status at pio mode.

Frank
>  			break;
>
>  		spi_transfer_delay_exec(transfer);
> @@ -1150,7 +1152,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  			dspi_deassert_cs(spi, &cs);
>  	}
>
> -	if (status || !cs_change) {
> +	dspi->cur_msg = NULL;
> +	if (message->status || !cs_change) {
>  		/* Put DSPI in stop mode */
>  		regmap_update_bits(dspi->regmap, SPI_MCR,
>  				   SPI_MCR_HALT, SPI_MCR_HALT);
> @@ -1159,10 +1162,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  			;
>  	}
>
> -	message->status = status;
>  	spi_finalize_current_message(ctlr);
>
> -	return status;
> +	return message->status;
>  }
>
>  static int dspi_set_mtf(struct fsl_dspi *dspi)
>
> --
> 2.34.1
>

