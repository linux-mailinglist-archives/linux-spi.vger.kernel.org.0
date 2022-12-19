Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BA6513A6
	for <lists+linux-spi@lfdr.de>; Mon, 19 Dec 2022 21:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLSUJe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Dec 2022 15:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiLSUJZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Dec 2022 15:09:25 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808EF13FBC
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 12:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXG2KP25hnhSWE1FAXdPxrYpQnEGSlXIbpK7z6xGqPDFRbodPpoZxTrmU+hZYUUjoXqtNAVW5j84K0e1Po19AsmIKvn4FBlDJfrxDW0x2wjG3FrZZUb5SniMskvfwvcmVAzL8K4rliiUrd3Usia68YFa9SzLBsFhRuoTyoY6kcXO05SypZxD9HIHs+QWvO42WGtJ16X8OCPYechyELp+wrU+gDq3GbsMkz+dM0FEMX45B6TXvhi9tA9SRpV9JI4Mt9AFems77eyDf/fM0dr8EzZbabFeedUD4KhLOdmH7NcvNhXzMKdWigyWGYJKt7lYSY1KR/D4+BMAUDT40q4fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4K5/O/hYPlDn+MQ4/XRQNedyOkUi1Ocgpbict0z3hc=;
 b=QvAoQHzz6sCbXJBshevtpCOpnaTB2r2whlEpBCN8EwWGS4lhiWfhtxTuw4v5PFxAHD8NBYpIp4wyUefY5YGDbgUuolxHRQ9mxlj4ZRNSbSPqCJjoIM/KLiVkxzkzYSsK8yCyiOA8ojWUTL9XYdhY9OPy3tibbyeZV5u7oE42eL0PeEUpBrqgwFWJWxIi6ZzYLNVDAor1vc6eGnAuoJzkRrf3XsaUZSB0kag58ut3/ekU+E/7TnXwqTn7YAhsojTliIMI+p5Sz37v4aw5rbWiaV64z42WP7yMluSCl68kEPgYJtgxUUCII04Z4NIQqChigzESUyTw/s1FYwfqTkQOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4K5/O/hYPlDn+MQ4/XRQNedyOkUi1Ocgpbict0z3hc=;
 b=YxDWuKjFTeIowJ0tAROyTrRTvc9z8sFxvMQGra5TzM277yK0K073EmCs91/xiEcCKgG1gPFQu6buYzOdR/SndAPiaZLT9lMP2GzgKugGh4E0XefidTLEs66zKhkPA361EsS/6Cf6TE8RoRgFjOWq6E5T96VeQIWpdSfZK/k4+9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 20:09:22 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 20:09:22 +0000
Date:   Mon, 19 Dec 2022 14:09:13 -0600
From:   Han Xu <han.xu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Michael Walle <michael@walle.cc>,
        linux-spi <linux-spi@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: DMA support for FlexSPI driver
Message-ID: <20221219200857.fckuqovt3xt5r352@umbrella>
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AS8PR04MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d1f0b2-eea5-4168-f252-08dae1fceafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnggvPuJvW+vzBE1h13rEX9tkH5L3yov3x+xjM5Go2tz9StvVPsZJTthZe38vQXpK0iStBPXzXQzFfkvtsriX/adBggZFwRPBMDrMrw5UvGkdWrvzuPU8j/n07R6BfWqPu4qU0rRc0mrh3W6vZoDiCdQkdXThz3U5Owq/d51rqkgiN3wTSRjkyTUDCIo88qB3cg0TF8ZeWum052PKbTlI6gTfkhJK8KJq4SIb3Eg7jauBFNJUIeg7nmmBzuGhu7VUN4ipQGnfQl1Pblme6djQbwEGMpzW2MjTZWRXcpfcXELddYbD5s+1Er1nigX7uYyWXqGL8t/cYwwP426O94zuDdC2WZxv82KNPNcPyh0q8+LOVhMAGU5ESJ4tcmqBWSSAnqOl4ukkZ+k5swBpuIB1MYTH9Bgw54t3g4JvRt2XtFNs6tDv0fOGIIjqYVnXLzLIZd+v6tX7DSUzEeQ4WBmlyPHMHOpRSWXQoO7vde/06aeuHHb/AG33DokSxSZR9XxrAfON8GWCUch0sMY7XJqeuFPiPNNaQf5VIjuBz7w5blBTI46I6cECHwYaZds7bps3HwO9YTRMt+PifbD2Mdc7IZJHekvfJz3Rrbcf73EGtdRYMf5Lb3+z6nxsO/uOoQGgGEGA2nhRQ9FVyiZvl7DKny26Tgkqhcrjo2ZhSo0sYqc+SsuPt9y4/sdTqTgUUou4VKdDsbz47CFjnixJodk2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(6666004)(52116002)(8676002)(4326008)(478600001)(6512007)(186003)(26005)(6506007)(9686003)(2906002)(6486002)(54906003)(8936002)(83380400001)(316002)(38350700002)(41300700001)(6916009)(66556008)(86362001)(66946007)(66476007)(44832011)(4744005)(1076003)(38100700002)(33716001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dQWSzXR2cpYAvpWnTBeKUF2BD/+kFIL1F/d2+ZH/kLYA1bBQPpSX4ntkbfv?=
 =?us-ascii?Q?aZFJ/aSjUb4WMbXKl8ZonQGQnMpruwt19Nrgc4Z4mahYhrcyR5+6ZG/kzuY8?=
 =?us-ascii?Q?PEVLSAEugt2kbLsTOkaI/LRhOR7LPmEesRvl5APF9TICFH48+Kjarin2Ldza?=
 =?us-ascii?Q?oxivUXGDN7LKfGLZEsykBh1bxrQU4ac53GNEEIcDiSs/khIJeh9IiOvXeFRs?=
 =?us-ascii?Q?J+CiFq2FML/PNtPdBy7tJGPSWqxU9JCy8zsfTb/EE3Lx+GBYInHlzjEQtjZk?=
 =?us-ascii?Q?s3pqoH43rohulwHeelyyN4V1TLbEJyJURfrkzNIddjt9Lt/QoOO7r9krV9eg?=
 =?us-ascii?Q?0vgrLfKv9ErQgdkP1LH964Drs+juxXPYEKFNpB0Lc6gpf2cf3i5w6tsIlAwT?=
 =?us-ascii?Q?4w4t98oSd5PDH7a5NdDtOJZ3gtrpYZdmfXUCpEC/r1ndOilroFMbI8ifFzrZ?=
 =?us-ascii?Q?TpTOUWPGYrtSeXAibOj39hQ8bveKrqZk4lSzX0hizOGlZsS3DqMKrbGQsLIA?=
 =?us-ascii?Q?FP1afrdz419mjUloZfmdeZH7ERc6xrafbkZXOmbGWnGFTR7uvOYlZTX24XOV?=
 =?us-ascii?Q?tLGQpcCyLs4ZLTOPw6FyvrtAb1dbxASOzr2z6gJeTKLMGNfVPEeOykgvleWz?=
 =?us-ascii?Q?pAaGdWCTvYFYmLEP+CftwFxo/AfxOmt12hGD5SIVxu6A0Bx784OgzwDXPGwJ?=
 =?us-ascii?Q?FhodF4yt1gpjVI+90RjPectHlfnUPug2vlC5JqLGT+DKaBPAe6GwPBa7XTIj?=
 =?us-ascii?Q?YQJ0gWJimTg+c6C/sg6eMFt0NeBGiGV5prxuwRJkmik1CSii/dPl1SRH2eCG?=
 =?us-ascii?Q?y9hH9nMGqrUzhDlzt+z4LtpE+iYhSMJV/U0GH0fPXPvOwGboH/UCF91mSDYM?=
 =?us-ascii?Q?xuh7iLmZgy6JGBXJd981z3ilvwusOQLzgtK+Mubvln+SMXUzgK0mNPRwuL24?=
 =?us-ascii?Q?5geROekGV2+jqypdhz5VzFR4cSRUzRwClClc9o4w9kPGLeAE6EPPuEVoI8fa?=
 =?us-ascii?Q?ponR9PYUr6O10xURb9Dq8+KnzPuOgXptn0WoQt+8qcSOJxhJiliLmncGj0lG?=
 =?us-ascii?Q?AX6qO4oWWcp9QFU6g8F71tW53sOhxve4eq9rs3vr53HjRFCmHb/daYWs/EYE?=
 =?us-ascii?Q?1gvHfuxwI+TxIP6ITDvPNS+2mLZ0breuO0a0MNEvd09EKfKV2umeLRw8ZmHa?=
 =?us-ascii?Q?UBVQTWDrLAgX1BRPnzEhDSZON1Yjzy6tjKNACpxX7k+7CuIPRxEn9fPU6k9w?=
 =?us-ascii?Q?dYnRPS2gzVkQhwtXmFaJejeNOAnQEigzw4qRysSGfCqHT19Pni/ZB07CeEHj?=
 =?us-ascii?Q?1n95vwNFXZ4iXKeJPLSjZIPLxZyciM22paovEDWOZQbQkpG/V4rUiY3sf0Xp?=
 =?us-ascii?Q?O1OcUPbJA0B2HuIL+JzjuoxE9zUcUtHcCEzbjCqjnPNqy/thBYpLeYcngtLb?=
 =?us-ascii?Q?b6kDQkPoVCgVvUU6wcmbPFobcv+byyOarkHsSXwkQz059Q+jd0JsFX5Sf6nZ?=
 =?us-ascii?Q?QOCwBUX62EGAf2e1IAZXhdvJOBDw7gc4KXQnkSSYPUZVyp6dtt9iYFgxL7xb?=
 =?us-ascii?Q?yn0ubrfUky7cuQzOO+E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d1f0b2-eea5-4168-f252-08dae1fceafe
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 20:09:22.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPDc7mIGBY480UzPtyXGl6fn3AGHuYwn5KW47uriW5vfosKec4usyqn6VWi21cUX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/12/19 02:08PM, Fabio Estevam wrote:
> Hi,
> 
> Currently, there is no DMA support for the drivers/spi/spi-nxp-fspi.c driver.
> 
> Is there a technical reason that prevents DMA to be used on this
> driver with the i.MX8MM?
> 
> Also checked the NXP vendor driver, but DMA support is also missing.
> 
> Does anyone know more about the reason for this?

We are working on that, both flexspi driver and sdma driver need to be updated,
and will upstream all once done.

> 
> Thanks,
> 
> Fabio Estevam
