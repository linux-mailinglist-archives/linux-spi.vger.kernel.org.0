Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C935FF39
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 03:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhDOBXh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Apr 2021 21:23:37 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:35937
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229450AbhDOBXg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Apr 2021 21:23:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxYuWVKRkUYTcwoyA1Wj2ousAhUV2sUPclPGPBW/kYiaO3cEU0fMb4199YVFhds5FTGrQjrSR7thfqkF0teqe7SHRBYzR3QUMsLBf9LxQj0NdMnApcFjqcj6jil0uSG9+cYrZRHRSh+yyalPIzsB7ON4hvuKlLw6g1RhpvBk4bRuW+7mDUalGLkhGrCqfCHucXyoKwZ5To9ARhPjFHAHmEfDb36F2u2FfHNXYwCzFkiGIr8gnLQl0B/ioeDZWR9Q2xhlet2TpgH0HsDW55eaJNhminySL14+wDZaYd31OrYUpv7Vdh1RHhyfUzn1xldoEBiyr8EQ5r5br2AhWZdQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDrbCYCRnQoCqUO4ZYS5oPFYum9M8hTX/ZFF8jH60Vo=;
 b=Ux4ypMHD9NQOYc7ihHEJJQbIXtKd7OclXT7CvZA09FM7Gy8yncpWuU99m3kXfgV3faLeeKkF01Pbas0XabnOXY/cOoM3dqzkgu03I+Ah+EnQWGlccnL8hZpeQ38AnDsM9hQM7ESdHQLvqlXmFSLOKdZ6N1Jy5rUIXq3PcDfHReF/PbzDqar2KdULj5SzNyALEw2qgP3N6R4otAoI59VhL7/Xn1LOov2ocp1uD+aqj04z6xiWVbzu+CGAo3fbnkPV0rziYV2/wRKn5cAzOPzRu0gkcV5aaviGZVLCzQvYpHCcbx8VmiFbnub0Ub/JvnPH10ZnW6wNkLdryB3GvovDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDrbCYCRnQoCqUO4ZYS5oPFYum9M8hTX/ZFF8jH60Vo=;
 b=aEVJVqZRhv/usAt+4TfCrSrqLVkTZK7FdHsreVbUDiBGzA95HWNdYzcwHF0/+Z+jqLCEksZtpGJIVbZOBeUArP9XcHQFcWwB8wMyPRJ11RWVSfyCGScIgIrn9eOHZOp7LG1ZTJ8AqaG9GY2exlf4IOsxwdinrmZHGE7uEspdTuU=
Authentication-Results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1544.namprd11.prod.outlook.com (2603:10b6:910:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 01:23:10 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 01:23:10 +0000
Date:   Thu, 15 Apr 2021 09:21:58 +0800
From:   wqyoung <quanyang.wang@windriver.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
 zynqmp_qspi_probe
Message-ID: <20210415012158.GA2465158@pek-qwang2-d1>
References: <20210412073154.25011-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210412073154.25011-1-dinghao.liu@zju.edu.cn>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1 (60.247.85.82) by HK0PR03CA0097.apcprd03.prod.outlook.com (2603:1096:203:b0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 01:23:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afd654e-cf40-4111-1ba5-08d8ffad07f6
X-MS-TrafficTypeDiagnostic: CY4PR11MB1544:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1544C7647C2D9F14986698E8F04D9@CY4PR11MB1544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Yu2mvnLtiqAkTLImBgOSqE8mxrGPcm2+V3hpSJR+iw3QwItU0NQ8da4xw3LjNa+lRuOH8HefFf1Dzo/8HcdUFjLa51NK0mPtR9yiF2xzHFLeB0W1dc6FQIXtmWDTdLDBgV8X8P1UWbxhiTBc/4PlleXJTHCMl6U3gopqoW7MD13D7SxnrfDu6ZoPcVm4amW3bHn2qDfaoGtVotnpoEKS8g3JxhX1oecDs907t+i3UzIUuo4igutb07Z+PGbzpPWX8TwCPViSWJzV37u0GTscifP+hXe31/9nDSrGH6oa+Kc3u8DQwklgud7NrVoiSJaczvUiB6yXSXdP16RmnTdYlHItTUHRMdXSKV1nWOfUPYMKeu7W/1F2LAXQPPwauC4wPhEcnBiB3rQbK0kZENgUmZd+qg1EuBoEoVNTu9V/j/Gc3BiYBxwArZaulbKr2rKNvLutqKmbd6dXfuDv0+tgHvTJcKFS9LFsp40V3jl0TdM0h3MBfQpA3o+9MOOjsD+gpjrpr8d+WGLCtsf9Gnhrz2TvqKgGHFM60OFLaAznl7nOf2+COzOEtxLfWXFauBcdtC23fdQPDiakdNvjNSYnhnhUMdHAK/+xYzZFaNgqkQV98jBz2sLQ6ZaQR8/MIvr95I07PogESdH8q4fAwxGC7mpgvgUyA6utvaK6V3c/38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39850400004)(376002)(6496006)(16526019)(33716001)(52116002)(66946007)(8936002)(86362001)(38100700002)(1076003)(5660300002)(83380400001)(478600001)(66556008)(38350700002)(6666004)(956004)(6916009)(9686003)(66476007)(26005)(33656002)(8676002)(55016002)(186003)(4326008)(316002)(54906003)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eGxiNnZ5TDJqS0xQVE9xK2lJRDZ0UHBBSU85S1FDM1RGSHMzVlpMVm52aUhx?=
 =?utf-8?B?VllDSS9tck1xNEhVbjJKcE8wVS85VHA0TGd0UzZ3UE5BSXVCazBGY0xKclM0?=
 =?utf-8?B?UkptK0ZmaWt1NXVicFJaV01EVmxobVhncFg5aDB0YjVnL3RHMVl1Vkp5Rmdw?=
 =?utf-8?B?eGdYM1VrTVFmNmJQUDRRQ2tKSUEwNjhDdG9BY1FqTTZobmk3dWJQVE1xMksv?=
 =?utf-8?B?eTVrU2xEZW5NaldOQ0RGdWJXeDU2bEtWNkVzMC9OR0NOV3FXTnF6eWlmKzRP?=
 =?utf-8?B?bHovaHAwMlhYWjRuSmp6dzd1Zm4rUy9xSi9ZaytvTityeWxLRzhGR3BzcmZN?=
 =?utf-8?B?R1hJbWN0RklFUFA2RWNmSmRYUm1XQ2VwK3lmUzFYUlNDN2dWWUVIOHcyVzVm?=
 =?utf-8?B?YnVza05IeXBpZG52alRFL3RLUEphQkVwQ01HZXUxejQzV3BXRVdQcnQ4Nllp?=
 =?utf-8?B?U2gwTkRiQjlYZTg3MEo0TDVWQ2NzejcvNzVZRlJZTFBBVFJQNzMvSCsrNEJX?=
 =?utf-8?B?TXdOd21zRytUbWNIbnVGck96NElObDhYNjkwSE1XbXByME14Nzc0K0wraXZq?=
 =?utf-8?B?YldqaS96OEgxT05YWUE5dzVEcWFUNkdDOTVPMDJmSDB4YzUyUGJIUWZPcnE5?=
 =?utf-8?B?WGNWNTJzUnJJZHBBUzlEZGcyeHRha0krMmIzZXNiSGpKZTNxZ1RIWlY1WWhE?=
 =?utf-8?B?ZnoyWm5LbGxSaXVEY1VUVGE1RFVHZEdrMlZuQmJZQzJiWkQvU3A0bWVVQ2ZM?=
 =?utf-8?B?dHhqdnMwZUdVbDR6SFhQbGhjT2RmM2duQ0hxTXkrQ2NHTkwweGtRNHB2bzhT?=
 =?utf-8?B?ZFNyZ29QMGU0SDJ1YU9QM3oxZURZR0VsaXZRTHNaaGVldkJwd0YrMXRBK1k5?=
 =?utf-8?B?SW5vZjB1QWF3MUFibmx6ZTlpMHVDTnN4c1pzejl0RXkyYk1jVEFycmZmakNh?=
 =?utf-8?B?cDl3N1N4YU5JRTJmckhuc3IrR0FPWWw1NzljeWV6U1I4NExUd0h0OXYwcEI1?=
 =?utf-8?B?cmRrU3FiV1FtVWpWeGNVZzRma2s2clBhM0RnbVpnQjF5RzV2ckJJZ1FReEdC?=
 =?utf-8?B?L3BIRTA1emxUN2FvNjU3WEcvTDJIOVJRbDZoV1dXSzB6cGQ2UFZLQ0U0WlZK?=
 =?utf-8?B?Q0NOWUE1cGZ5OTNRNk5USXRDRzVudmVrbEVpWWdFKzJXMlBxQ3JzYlBYcm4x?=
 =?utf-8?B?MUMyTXhWdTVBSG9QT3FqUGc0MmIzNUhtbFAvWGZ2KzJncDFqVERHQ3NVam93?=
 =?utf-8?B?dkZDZGJIVVRHT004am14YW1SSytGd1pDSTRyN1hKTkVpK2hmWmxXeGdLRVpp?=
 =?utf-8?B?RnN0SlYveFZTR3hjMFZoQnpTcmNyZFZuWEs3cnJic3RISHJNSlluK0FaZHlN?=
 =?utf-8?B?T1lld1lUOGU0ZVd3WjE2ak1tTmZsQXlmdUhicHg4NHBocHBUUUY0d3pxL3Qw?=
 =?utf-8?B?ZGJVTVhCZHhMY2hUY21ZMVVnV3BJMWx1TDkxSFE2S1UwVmJtWDFSNjBMM3dJ?=
 =?utf-8?B?dkVZZ2NHK2JFOFhKN2h6MVViaVdydjA0amJmWU5xbE1hNlJyRFNaVS9paldq?=
 =?utf-8?B?YmhkYVpXSHJVd0NEL0ErNXpuT29ZZ2xaTWY5NWk1dnQ3bDRSdVJKcVdTZExT?=
 =?utf-8?B?UlJXeFhERGhnTXFNMTRjMzUxU1M5dlBpVmcvbFBxek9HZWFzNTYxQVp3VzRx?=
 =?utf-8?B?cjd0QVZQTndxc0hZUTdET3VsTGN2Y0Q1YXgxZkhFc2U0NGpsL011V2hhV3Ru?=
 =?utf-8?Q?fAPm/MQd3ikKk0WbdNoBGfidfeniUpuNa+CFAJc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afd654e-cf40-4111-1ba5-08d8ffad07f6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 01:23:10.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fWCE+Y4zJ0qdgPi/Wtbc4gVKFNHgMt/Ds+o9MUvOq9A+xkPUZt29d/XcDzmDHhXLLxFb4Pn8OAmA63DMgNzyZNdnlX2niWWb9frqOzER3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dinghao,
On Mon, Apr 12, 2021 at 03:31:54PM +0800, Dinghao Liu wrote:
> There is a PM usage counter decrement after zynqmp_qspi_init_hw()
> without any refcount increment, which leads to refcount leak.Add
> a refcount increment to balance the refcount. Also set
> auto_runtime_pm to resume suspended spi controller.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> changelog:
> 
> v2: - Add a refcount increment to fix refcout leak instead of the
>       refcount decrement on error.
>       Set ctlr->auto_runtime_pm = true.
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index c8fa6ee18ae7..8b21c7b0e7eb 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -1160,6 +1160,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
Please check the return value here, if ret is "< 0", goto error label,
and a pm_runtime_put_sync is needed in error label
>  	/* QSPI controller initializations */
>  	zynqmp_qspi_init_hw(xqspi);
>  
> @@ -1187,6 +1188,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
>  			    SPI_TX_DUAL | SPI_TX_QUAD;
>  	ctlr->dev.of_node = np;
> +	ctlr->auto_runtime_pm = true;
>  
>  	ret = devm_spi_register_controller(&pdev->dev, ctlr);
>  	if (ret) {
These 2 function
     pm_runtime_mark_last_busy(&pdev->dev);
      pm_runtime_put_autosuspend(&pdev->dev);
are the last operations in probe function since if they runs,
spi_controller will enter suspend state and disable clks after 3s
passing. So please move them just before "return 0".

And would you please cc me when you send V3? I am preparing to send a patch series
to fix clk and suspend/resume issues which bases on the pm_runtime issue.

Thanks,
Quanyang
> -- 
> 2.17.1
> 
