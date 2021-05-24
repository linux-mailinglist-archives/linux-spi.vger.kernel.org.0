Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5038E23F
	for <lists+linux-spi@lfdr.de>; Mon, 24 May 2021 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEXI1C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 May 2021 04:27:02 -0400
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:25440
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232279AbhEXI1B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 04:27:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/HIThk3Ous0tkJhxHO4anCBzdFQ0YaQOX5bVf+bhTWYsSQ1G0R8FmAT9N1am4nR24Z1gTQU2pEB2B66ukpghSz0v/V0MvqD2OfUFjhSqSZ/Pr+quy78Wypl0P4ZfMgWuon4pebnOltJBiIHASFLRDPFrCgvgTlOPzuIoYo1tWHcqmkaEeSaJJPcL8zqYhJasWmgtRKFx12Z8SYyukn3V8GuMSwdweX5OckhMguIiItb7AYNpRdD92+UlKu7cc6UEsGE5MyPse9qlAOLs3EmvnghfnMjXYTv8/AUTTCGf01mN3IvnTD99D0N76/4nLxg5ZQLU4nuW9FSPM072nYt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHHagOW2yZ9HAMC/rwNEWlzWUrooJgb12nsEZyjkuZU=;
 b=B5GdYJpIX5rvhCuvLtKV2ClGzuQRRmzT1lJDSrNMAV4y+k4kjUWOPWYM0yXUJNJKGTJFIdw1g5rKuvPQFmSyHCfj1uWIAvabetn7d7Rp6d5dOZpg2Se9X8KHnSPcOopFqSIWEwIu+irU42Os2xdFVH+ImWK19Q5c9QvHsVNaDEZzIUpUp2ZwVelc0vVtaeFJ6PwwZZtOgvv5PwUVIXxw3buEigJYVpPX+VTJyFGfyYcq6zDFHV2bwwwBcyp+gXauCnelbMhM4QrjxtdcoCF/HIFn8fUy21JcCnv0BCnouzMPGd8NWvVIPpAj8W4JDZbQjrAMcPAooZD37JLbPwvjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHHagOW2yZ9HAMC/rwNEWlzWUrooJgb12nsEZyjkuZU=;
 b=OPBkEQHPlYcHn+eEOEoItbTsI8H1u3wxmJ7xjli7jga+UkXCrFiR5kBx5M03EaetkidI3fbw7ETc5h8YbbOGmZgjcqgZHHFN4jk8+FPY2KLCuG4fknxui4NSCFdu/CldeOid2hhISYJXpGj10V5PNXKEdmjjQwwA+hzYzRQJJ3PxW2z1lhxR2vrvOm/Ux+LR/3FmJ6I4GZSQA/4q9fpgwWOZBjsrOC5yap10BMMmAlNV0TO+QZsaG/eHw6z1aYn0R3omZxde7hMSsRVggLnE151XTyi52VLmWXA7Zh3+D0tZ3IoJtx6WWU4NCCm5JnUd01fHVmhzfmvm7tOJRBkiOQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB6576.eurprd06.prod.outlook.com
 (2603:10a6:800:128::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 08:25:31 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 08:25:31 +0000
Subject: Re: [PATCH] spi: imx: add 16/32 bits per word support for slave mode
To:     Clark Wang <xiaoning.wang@nxp.com>, broonie@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210408103347.244313-1-xiaoning.wang@nxp.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <961ec8d9-d96e-2dce-f2d0-b10299e10afb@vaisala.com>
Date:   Mon, 24 May 2021 11:25:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20210408103347.244313-1-xiaoning.wang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::15) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.142] (85.156.166.106) by HE1PR0202CA0005.eurprd02.prod.outlook.com (2603:10a6:3:8c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 08:25:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd182b3-5eda-4b71-9525-08d91e8d7e86
X-MS-TrafficTypeDiagnostic: VI1PR06MB6576:
X-Microsoft-Antispam-PRVS: <VI1PR06MB6576D1861C2316DC7D1A076CFD269@VI1PR06MB6576.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaa1U4lpq3l5WM+iOOWenZzJVg+YOhfSFmEHfwT9WS+wOrnb9e3DMZ/A9//E/UH81d0jWpT+cd9vN1le/d1kb44HVsKYkwNM5rMuqDnEzYwDgNnSnDC/hVJP8ABLy3ZFXU+Epo/H/I3ll0MmkesMQOnRMJgeEJ0tBoLrG1yTNmhtnaXyUv0RNOwm0C/0ASLGEtgx+3iwq52/kmQYcA076JC+ZH9oDiYP/hWfGo2TNc8+1ow1itER5yPv/A9aFmgDU8vGtHGRkly0RejnGQ+G3YMpdSOn4NlE61HE8jX6OkWKys/o3vS+K2ZT4GPvxIgEdTvhK4qURlre0ro2aVn5Uu+rTD8qFhxgPpkVpWwvVKqrf9ACHkZywYMoWr8+/d+Oa/oucWEON96UiHXP8aOjK98rH1rwFNLmvN3j1pRvtoYAdmNx6XUKbl26mYJLwe4cjHPd68Ik59m2il7AbJTJQavFZ7ze5nQVozuQ0/EctDTeuxCOalvHa08ukUnAe0yCebnjUTx4sTyYlnYoOMmz/LKsr7n99hMJ9mJVzKh+1lp/SXFkQUSASy1nPHfkCsbCJOfkTyfbS/oCZPmIAYOGRv4WRWHiupvGSzCN9Hqq2Bj5CQ6nRRGARd92Qlks5TQMcDiL64WtejuoRbzEClhjpMG22XDIqwe8dy1P/rRYqkmpx8JOdFT/By12fTLr5nJ9jDnD7NUkR0hPjM5uccbxVE/MW6dkx5zxP4yRZsUGdbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(376002)(366004)(396003)(2906002)(83380400001)(16576012)(38100700002)(38350700002)(52116002)(16526019)(86362001)(36756003)(316002)(6486002)(186003)(31696002)(7416002)(8936002)(53546011)(31686004)(478600001)(66946007)(26005)(956004)(44832011)(8676002)(66476007)(5660300002)(4326008)(66556008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXY5YXNMQTJHWGlVVGc3UGU5dDdzR1drQWlmV0hPaU5KdndST0NvdjFKbmxx?=
 =?utf-8?B?cWxPTktEZTIrMUg4QjNPMkdMbmZmVlVBRnNpMjFOMXRsWDdyc1pscjdMNXRI?=
 =?utf-8?B?K0IrOEZmRHpCNFlaVFAyS1duc3psWE4zQndBR3VvdVZiQmo2Mk03aTVxSzVh?=
 =?utf-8?B?Y29mOGpxajNFTnZhTWp5ODFDOFBWbG0vSE5KRnRXMit4cFZrY3F0ekFGYllm?=
 =?utf-8?B?ZGRpK1NiYXViNW51Y213VmlvbVdnK2J5N3hOY3lZTmpPbkdvaUZUbGRVTFlE?=
 =?utf-8?B?bVlFd0lUbDZkRksxMjJyMVd4OW5WUHl3NmY1eC84U2dmR0NoNVpaREI0Nk1O?=
 =?utf-8?B?c1k0NGRWWXlzYkdZVm4wY21XbHpOcFJWM25YUUhyT3pJUFZOaHJxSW1tUnNF?=
 =?utf-8?B?MUlFRXluZDUrSWU4d1pzUThua3dod1BkN3FwT0x5RllOd0Q0Z2RRbXRMdG55?=
 =?utf-8?B?RGk4b2R6V0UwMGhqdEowOGJ6MllpSDMzYitOZkFISVd5WHdtU1lXTVR3Uytn?=
 =?utf-8?B?Y2ROVGtHb3pxdFV1MHgxclZHd3N2RUovNG5qTkdpekdoeDBYVnYxdzhEU0lq?=
 =?utf-8?B?TldiSDc3emdDMzN5MTYwVnU0SWJROWZGcnNMTDhBZ0dkZ1ZSUUVneTZzNjdj?=
 =?utf-8?B?UmZlZDRPYjZycTBzYm5GVXNnVlZ3YjlTVWJ1NW94djZESmFMUEwyeFljdllo?=
 =?utf-8?B?WGNlZWl3Q3dSWnRoOXA3VjBYZVhHL0xVL01HVm9LVjlVU05HWjhma1pydDds?=
 =?utf-8?B?czFRSnErSy9meW5HMU9XT1ZBZ1I4SDE5UExVMXNTRmFUWkl2Q1pzaFVLZmJM?=
 =?utf-8?B?ckt5WTZSSmU2bWw5OTUrMWllVXE1MWNsUUpLS0J0YmhqUEhHK0l6UDFKUlRW?=
 =?utf-8?B?QW9ER3JTWEtvc0lRYkxLU0gvRGsyY1R2NmhDVzRqWHJLc2tRM2FuR2FmVDVr?=
 =?utf-8?B?U0QxU1RScjVMeWwzTWhtdG93L3ovZkFhY3hlazM4VzRaT1ZZR0hLK1pmVHVy?=
 =?utf-8?B?ZU5JZlRwNGFZMHhvRTZxMDRXY0lENTlOTlg0RW1yTmk2SGVnZWJJVUNvUDNR?=
 =?utf-8?B?bC9BOUIyd25iOTZxOW1lREk2TjFnendoai9tN1lWd1VmRTVldzlISXFYSWFk?=
 =?utf-8?B?ZjhWWWQ3NDIrQWJWZmhJRHUzRU1WejloNFlrbkw2cDF6UTM0QWxxVDNFY1lL?=
 =?utf-8?B?OXErTU5MWThzVElKT2paSFZSV1NzSnVmOVJvYzJ4TkF5bllReFVMZkhUWWcv?=
 =?utf-8?B?M0NRZDNkUzVoWTdhOTZGcW56dml0ZHhkbHczU0xoTjlzNzFnb2R2OWR2clA0?=
 =?utf-8?B?MG9YK0FwbUptc1ljS1N1c3lkMGY5RHk0U1lQNTZYV0plZnd3a2Q2Z0tsblBU?=
 =?utf-8?B?dXlpdHZNb2FYaTRxM3NBNkEvQUJ4clhDSGZLaWlIMExoaFdFZW56MSt5VlIy?=
 =?utf-8?B?QUdIdzlVb1VIMis0YzlUVVBFR3IrTWdqY0l2U3ZhSXJxbjdWWjJDUWVZdmFF?=
 =?utf-8?B?UWNkbGlKRmNZckpVd1ZPN2plQzl1ejFkRHk5d3p0T1ByNE5wUENOVmRtbzg5?=
 =?utf-8?B?SUpwMWI0K1FSMU5jNjdGUXE5MW9yd0RzOHBGZjRTQkwxT0djTTdZTHVSYTFN?=
 =?utf-8?B?TXhEeVJZYWVKdDRjNGgzNE5oWURPUmhOM25vTTBSeXZlcC9ia3IveEZvZ2Vl?=
 =?utf-8?B?NnBLTWZWOUFPaXBLc1ZVd3piZmpMMm9XQW9BcGtacHhqUldLdjFBOFZ2eEha?=
 =?utf-8?Q?/Zvu90DHRBdVEZ5WiY2EGz8bjGjLfCKJbl8lnpS?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd182b3-5eda-4b71-9525-08d91e8d7e86
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 08:25:31.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbgw1Uir3LcvoMzx+s3y+RksMazz030zgPLB7yJKBU8Eey85QmlUzUIal6EVOO0Wj6/KHSvfXbe0GovrUYvZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6576
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 4/8/21 1:33 PM, Clark Wang wrote:
> Enable 16/32 bits per word support for spi-imx slave mode.
> It only support 8 bits per word in slave mode before.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>   drivers/spi/spi-imx.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4fe767acaca7..24ba7ab1b05d 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -386,7 +386,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>   
>   static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
>   {
> -	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
> +	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
> +
> +	if (spi_imx->bits_per_word <= 8)
> +		val = be32_to_cpu(val);
> +	else if (spi_imx->bits_per_word <= 16)
> +		val = (val << 16) | (val >> 16);

Would it be good to use available

     spi_imx_buf_rx_u32

     spi_imx_buf_rx_u16

     spi_imx_buf_rx_u8

helpers here?

thanks,

Tomas


>   
>   	if (spi_imx->rx_buf) {
>   		int n_bytes = spi_imx->slave_burst % sizeof(val);
> @@ -415,7 +420,11 @@ static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
>   	if (spi_imx->tx_buf) {
>   		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
>   		       spi_imx->tx_buf, n_bytes);
> -		val = cpu_to_be32(val);
> +		if (spi_imx->bits_per_word <= 8)
> +			val = cpu_to_be32(val);
> +		else if (spi_imx->bits_per_word <= 16)
> +			val = (val << 16) | (val >> 16);
> +
>   		spi_imx->tx_buf += n_bytes;
>   	}
>   
