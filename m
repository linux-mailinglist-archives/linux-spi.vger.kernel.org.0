Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E185F3E201C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbhHFAmQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:42:16 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:44954 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242935AbhHFAmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Aug 2021 20:42:14 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175Nwss9022261;
        Fri, 6 Aug 2021 00:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=SDxSJZ3zbLbLKFmLA7cfbkrHHoD5v9LG/gg9icYRlEY=;
 b=b7m/Sl0XVyz+svtnwAOFgDsbgSAjPcKgGaqPokrNiBEkA7qrZjF8Wbwyc7HAscGzB6c/
 iMYUqHOQD7bST/Qfe0vu7eDSQEtDYa8uZUNzvLNtN/79XzKEIY49PX5qQ634fc597YvA
 S49njyxBXM93kPIwUfH60KUfOGdRvz6YjzxxhOdW+4y7X2TP1+TifVLIqyhEubd/zXHE
 XDtbDsf53VYEGRCo+11UthkaBNqlYG/KzQpTPJ0ZGpWiz1NUcxF1F8oZPf9QnMPrCfgP
 Nlodca6IlmYxagFlve8KlvdQMVdBBz/T4OPz9qO1tbF4ckK8fxaiNzi4uOisS+aQ5cV6 Ow== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-0064b401.pphosted.com with ESMTP id 3a8nh086cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 00:41:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg8flXY2ox7Z7zw8x088jJXdMYYSyDwIPmuXbrLn1XwaJstl8oq25WgA2pikfOAGAn1rOIj5AMF12cDqd5dEKqAlYOmjacPy9irgdQyaA+wsuRW5o8gqNskkNjyQkU0rqbtf4Gs2xmK6b7g4YIaSR/YuUFkUl2ekTnhlZ+8pKP7xHJHYI2s9HRUjfRCxJZ5lE0pmsqzGsrdsWK61D4dZyWevIhCNrtRhP9PqsUdbokx1kLBZ3jCd9hb6h1lqy0q91ll9985fwShp5XpnZgC6z8xnyhmCRaKEgfe6mblsIfxDQyTFTzBOXyXv4LZBkigvNCEUt8sHb/I7dlWO3N/8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDxSJZ3zbLbLKFmLA7cfbkrHHoD5v9LG/gg9icYRlEY=;
 b=fuu6X26iJvxOulwhlMiz9FHlyaJIYLEr/z1H8+Hu9emRXCDtbVOvdKq8hNJ+uFom9vvFEYfSi3lhe7rflFSW3eKwSH9B8u0jXVfrSyNBKFN2XGpXHZXbDnYupT0MvMa11HJytNbFOyGc6yMlds/DX9ugu9gKbX7O+ZC4Vs1Rt7QcyLWb/Qq9rnL9t3l+3rOX21VHxnJVoCgyyEYJvvXXhs3a7S7mQdHSzNrvdiEcezEkq/7u9LALp2+CGX5pTSVFaTNqn9MvV4wuZQOSYfXbaCQlH2utiBFJX7oQy3SFpESTVwEE3SRnkazve4370HSjXGs3WUMYWEM5lBbKyoieAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1478.namprd11.prod.outlook.com (2603:10b6:910:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 00:41:50 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7%7]) with mapi id 15.20.4373.026; Fri, 6 Aug 2021
 00:41:50 +0000
Subject: Re: [PATCH] spi: spi-zynq-qspi: use wait_for_completion_timeout to
 make zynq_qspi_exec_mem_op not interruptible
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210730031753.1317917-1-quanyang.wang@windriver.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <e639bfc1-ce6f-c5d3-6412-70d03706127d@windriver.com>
Date:   Fri, 6 Aug 2021 08:41:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210730031753.1317917-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR02CA0135.apcprd02.prod.outlook.com (2603:1096:202:16::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 00:41:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f613484e-4ae4-40b3-357a-08d95872fa7f
X-MS-TrafficTypeDiagnostic: CY4PR11MB1478:
X-Microsoft-Antispam-PRVS: <CY4PR11MB14781F71A99C04930FE7D1DBF0F39@CY4PR11MB1478.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4R+sF+k69nWH+/ta8Fr0mJP+J8WI823ZsV21tmcSo0dNhl2ag5V3u1zzvi/hTdVj5nRkcxBBUW+Jsn2YyOOhwHqI8nHPaocQnlkLTvd2P+W1RrVmb4Rcrr/fhGzYjJVCMZWhso8dD0Ag3+7TOioWc7l2zm8fJu1VRAyYSrxFfVj01XqwiQFgVFJwD9BaBYVwup/VbELoaQP5x78bbL8u7b6jljozSmrqgUKHOHi7iyU9xpo16qdoUfahKLhFwkLdgl7yVDsvh6hfSFjmgL5t0LLwgS4EVFlVtgjRr6BW8ooUMhYuViOdnIMLflJVltwex1anDncGKAP9WewjfCc8EZH4OpxPQET6vxpJpusteEOBpvmbUppdcpWSV+Zdu0LVJVhXbCMKJ+w98MgeJK2XFNaJDu759G9jbhPgxTKFBv67njcLghPBcFIAb+2CCNMrjRkWgzVrJvA8O38wvvJxEqKfQ8uTKBh1EIjAB5C5nppKIzGMfx2RMC3c7aPXjtDA3CjqpfvxJNWFchpHDZlx0qYk+K8AJ7Jad86PKkD92GPhuekEYJcmv3zfNzTFNwqylMuYuR5vea2YcHuAQT3/8eQZI8X8ESQfJIHL7N/4FqDA1NfihoZmrpYuxRfJceUSrmIJ7V/34qcj9rbbXrXyJBD5hUuHlfANcOhfc7bOrPuMqzELTiNkM6W+Jv1vvHfg6OamITyPKLK8JmURLwBDuVtfBHT6kki1iipr+1q6U7GrhbSiVzrdKTALAiCPNOyG4SIXrVmWZKfW8Sw0cUVW2KohoITX5IjaG4qX3NPA/Hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(86362001)(36756003)(186003)(26005)(6666004)(16576012)(53546011)(110136005)(2906002)(8676002)(316002)(5660300002)(478600001)(52116002)(8936002)(66476007)(66556008)(6486002)(31686004)(4326008)(31696002)(6706004)(38350700002)(83380400001)(2616005)(956004)(66946007)(38100700002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFnZERzaHZURWhGSUNOdGVzVUx1dkRUNzU5bTlsOHhEcVpYZlEyaXhvaXBH?=
 =?utf-8?B?NEE2d3JOZ1FNN0daRnJXYmhjbXB0UVlBRUlmYm16ajJneHZkR3pRVzFyNklw?=
 =?utf-8?B?VnBpQWJLQTh0WnBEQmY4U09BbUlzRUI2dTc0SUJFbmtCWlB0RGxuc282MmJQ?=
 =?utf-8?B?bm45L2xFcG9UR2tYRnM4OS9zN0tSbnRVa3pRRU1CTVhpREd5WTRBNTN5akMv?=
 =?utf-8?B?bU9Vd2VhUTBmRUYzcVhJa3FiaGtGQzY0RTkyOXd1a0RwaWpQa2YvMS8yRzEz?=
 =?utf-8?B?QXUzZDhndWNQY2ZZMTlVam5ENzVmRzlKQ2tTemtIc1ZOMElOQW9RbjdaUFMz?=
 =?utf-8?B?TXRZa3QydkN3a001UkNSc0pWVEdoeHI1Vjl6N3RVcEhaaEg4VldORUpnMm43?=
 =?utf-8?B?dTNmSlpQaW9yc3lRZUJPMWdSZEsxanhPREFwQlVLZGprejlTUE9PS3hZeFJv?=
 =?utf-8?B?ak5RUm1IVkRIZjNoMkpCMXVsZS80c2g1WWZiSWZIRmV4NDVocFhSZmhBaGhj?=
 =?utf-8?B?NGNFQ05ZaUc2UmdRRWxqa0ZBckZyTXVaUXFDZmEwODVwQ3RCMFBVS0lXWERj?=
 =?utf-8?B?YlptVnA5MVZGK3U5MnZKQnRTZG9VRXBtOTNpTkJFR0dOaUM4bEEyUStIU3Z6?=
 =?utf-8?B?T01UMkRyWDFwMkFvUmU4N241T1lrcmZkZDdraUlhdUp4TTUyVFZsc2J3VGt5?=
 =?utf-8?B?ZEY2UjU4YjlTQmFiaTBubmhpdUJwcTFwRVgvWnlkY3JpNklCMUVocVlGQnJu?=
 =?utf-8?B?V081TUZVUmdBTUpRM2M4M21OSGRaV3I0QUM4R21PWVRXTVRxWEp2Y3dQZDMy?=
 =?utf-8?B?S20wT0ZvenFJSkNpQmphMG9FSU9hWDhGalpBZlV2REkyRmozUjM4UURQT2tN?=
 =?utf-8?B?WUdQL0lFbWJaVG9BZitxVnhZcXhTWjB0RFhsNWRJWUFxaWl2ZWFiK1BpOWVZ?=
 =?utf-8?B?dnJ2SDFCTWVTQVU5aUV3Qkg0dVlEZUt4SHVhUkVRNmhSWUh5ZThXaC95cDJH?=
 =?utf-8?B?TmQ5cFBPMXJDaWxPQXM0UWNxa3VnY2xTS05lM3VHRU9HSlRBblhmcy9Fcmlp?=
 =?utf-8?B?Mmo5QXlWdXE3Z1g1b1JoUlova0plamoyQUFJWUdid1VTdldVSW15VmtPZVVl?=
 =?utf-8?B?YU4xY3dwa3lhbzd6SGtFaTZQczFlbTFmTW5lMS9XeE5BSk8wQ3VmdFhNdk02?=
 =?utf-8?B?V1dZeWYrcHpFVUc0UFEwdlhjVGpla0tlSDhuSldBU2t5VXVkQURIazZ3OTNs?=
 =?utf-8?B?Z1hlVzc3Njd0bldDS2cyRzRRS050Zlo0QzZsM3E1eFpUaXVSVlljZnQ0L3Fl?=
 =?utf-8?B?eTJ0cDJaMWFLeE5pT080aitSaUZvSGw4QmxwMGdaRUpDMnBqRTNYWDkrY1Qz?=
 =?utf-8?B?TEEzbUo3eUNlMGpnUVhDZFlWYlFoc0h2OVM2ZXJtcEZOVG9Uay91NkhoTFRs?=
 =?utf-8?B?aVVXa0VXbGpRSmVlVkxFUHd0UkdKTXFxYjFveSt0Ynord1lkTUIrRll2TUlX?=
 =?utf-8?B?d3ozZ1JLVXZ4N1lWSktsZ2gzd2p5Q2lWSkNZZ1RvNHYzdDN4QlhrelRkbGVW?=
 =?utf-8?B?OXJ1Q2o2QTkzbFQ4OWlROFBYTWhTd0loeVN6bnhYdk44ZW40bnh0UFZ2M0pa?=
 =?utf-8?B?U20wcTAwTG13bkkrMHB1Ulo1eEhqOUxYcFNkR3lpblppV2QxZnA5cllBeEpD?=
 =?utf-8?B?dUNsNVpYU1g0bFhEakljZG9KU0xqRWxlVUVsRzJuR1FIUzF6OXQxU1NDaDdl?=
 =?utf-8?Q?QPMCgxrEYVDU5aIVJH3rUlC0Eo/YHEbyAFl0mGD?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f613484e-4ae4-40b3-357a-08d95872fa7f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 00:41:50.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9tKsUNQJVTTBRk+75qO/WtwSexxhNjfVl8VBsKukSZTeZRCKOL57BByFelgxMOVZUMs4jzrtt2GHjLC7h12mQLfjkTuy+e/Y9RmkcUEcK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1478
X-Proofpoint-GUID: NTlCov2fWvanF3r7IUnsvCOIof2K7Ehs
X-Proofpoint-ORIG-GUID: NTlCov2fWvanF3r7IUnsvCOIof2K7Ehs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-05_11,2021-08-05_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060002
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ping.

On 7/30/21 11:17 AM, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The function wait_for_completion_interruptible_timeout will return
> -ERESTARTSYS immediately when receiving SIGKILL signal which is sent
> by "jffs2_gcd_mtd" during umounting jffs2. This will break the SPI memory
> operation because the data transmitting may begin before the command or
> address transmitting completes. Use wait_for_completion_timeout to prevent
> the process from being interruptible.
> 
> Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>   drivers/spi/spi-zynq-qspi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 9262c6418463..cfa222c9bd5e 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -545,7 +545,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
>   		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
>   		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
>   				ZYNQ_QSPI_IXR_RXTX_MASK);
> -		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +		if (!wait_for_completion_timeout(&xqspi->data_completion,
>   							       msecs_to_jiffies(1000)))
>   			err = -ETIMEDOUT;
>   	}
> @@ -563,7 +563,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
>   		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
>   		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
>   				ZYNQ_QSPI_IXR_RXTX_MASK);
> -		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +		if (!wait_for_completion_timeout(&xqspi->data_completion,
>   							       msecs_to_jiffies(1000)))
>   			err = -ETIMEDOUT;
>   	}
> @@ -579,7 +579,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
>   		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
>   		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
>   				ZYNQ_QSPI_IXR_RXTX_MASK);
> -		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +		if (!wait_for_completion_timeout(&xqspi->data_completion,
>   							       msecs_to_jiffies(1000)))
>   			err = -ETIMEDOUT;
>   
> @@ -603,7 +603,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
>   		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
>   		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
>   				ZYNQ_QSPI_IXR_RXTX_MASK);
> -		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +		if (!wait_for_completion_timeout(&xqspi->data_completion,
>   							       msecs_to_jiffies(1000)))
>   			err = -ETIMEDOUT;
>   	}
> 
