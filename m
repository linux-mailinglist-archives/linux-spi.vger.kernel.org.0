Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A887212696
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgGBOqP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 10:46:15 -0400
Received: from mail-eopbgr40135.outbound.protection.outlook.com ([40.107.4.135]:53688
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728179AbgGBOqP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOI2in0eqNkP9F7qWd0mOCi8og1JuFwTRXhFmNVnJsmG+43/3fVGn9NFHlye1O9nSYQuf58ghaGsYNrv+75iJVZWK4RVc3/H9e9jqNZ+NNQs2sy5B8R0iCDXvcOe2AJ6dSNP8s9BumDxpFABHfvaukXNddjaBdKNmlO/IUvuwO2CZH2w3BK4tQyRsnGkeuAIs5UQ4Hgms8WkkuIFlicDh0zP9xTNuasPdJ5bVysZgy4qgwSlFOOoQnnLtVkgIo6jdmSLNzD3U9jPfZWZmiea35M7T6soGA9E0CWyxKsJJCB9zEpqUMwtorWgxK3CbRkfRIeec6C003RXJVwsGTB3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q4ksBxAshyL4W2gLyNVZcRzdT3bGO8r0WZJ/eFW3vI=;
 b=hjhSV/mGRlekoG07Z/1IxjmJcpiUq3FNJ9d+/+SJ7LLI68o66qe1wbCeu1Z5i33aC+LvIx3QMW7HeS1qa6f0i/1AA4Gw8d1Ut2VKr1/XCTV/vqahzC77CXAmJxoiLFSRtrv6LmXRa6QPSh8QKrPG4Ggmce8ZeqtnDlfFHzeTfGX9ymjxhEetfa1UeLlTEiIWgOqMPARdFGTKA1vNzf44URcAe6SA0KJf65c4hOA3p4yWIMUt40xKgkBAto+3rwXWus/iUf58ipyTNu6CfY/73yhIxiQiHxIEZLVMnJtjWL0ZL1W7jvaD9N8haowvz8BEkFuxgdrwj7LaTOjRXu6KJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q4ksBxAshyL4W2gLyNVZcRzdT3bGO8r0WZJ/eFW3vI=;
 b=VnE9cToqd0e73SRAhwreyElTm8u83mf0yo9o7AUiOfQHINE12VcUfSu/nsyloOtKp8L+hqQqOaEe+fcOFbP2qx/imN8xtWhF6dfbK91skd6yzZF5mh2wAh4QY1sgJr39FUa6jJJXNVKHcztjGXF7XEl/NJy+sxK5Z4ViILm5pLI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 14:46:11 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:46:11 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
Date:   Thu, 2 Jul 2020 16:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200702142511.GF4483@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (46.142.79.231) by AM0PR02CA0096.eurprd02.prod.outlook.com (2603:10a6:208:154::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 14:46:10 +0000
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4935247c-4c94-4fd2-3f0b-08d81e96a922
X-MS-TrafficTypeDiagnostic: DB8PR10MB3276:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3276E9F95FCB725EECFB99F4E96D0@DB8PR10MB3276.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6Zr8UNnbphVSrdE8H7eTcRynJskZgkKx7tuFfN7+nTSiD5ZeI1o8snrKMCF3URsXLRfmplUdkDuzU4hVMmJMm3MyN0TSOjOAL48JY1nCEr2JmRwDtrQMPU0+lCHRqGVP9SUupVGcXoWZW8QDOPVykJW02Mp4VHxFrdSk06fQqbq+2pFS5OUMP1uQt6iHqJf30sTnY/p1O2VVVV5q9KHrVJnlOG5ZUNd8y+ysU6EFMZDRnUlcw4Jhm6tjesyVlaPQcdkzK51g19LgyZfsH4FIKVKpVZjWfCel9rrlvhvP8szo3bv4fVsuJL3B13QzWamnRnL7BwFAl1IKjYGDae9aAWhH6lr8Qbsy3HHzthgwJA6ehDRJ9w4XUf4w0eeawi7SDnFhjkt8ymGS1CHs6FsXAvk+PYYW/87z9q3+JHUHJiLyhN3ten1nvCn5FnuDMXTMfH1n6lbSSGwY1714dggUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(16576012)(44832011)(66556008)(53546011)(966005)(66476007)(6486002)(66946007)(86362001)(478600001)(31686004)(31696002)(16526019)(4326008)(8676002)(36756003)(186003)(26005)(8936002)(4744005)(956004)(2616005)(316002)(6916009)(5660300002)(2906002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: udRDO0mphqLqc5cxp8u63Qg5XTpiZ2SaXrhl7wSt/YlFdQhVUE54Vk40aYcQOYyzX8HqpWAEjiGmNOUlLHi6+PzQE/lBKdPwBuP451g+/S7wbfKLB7YOZerNBWx1Lpc+kVaddYUpJ03FLd0dZO27OoKdmjpwhPB08rGbIS4cpPkm8m7/u1FG77naVXc9h2+hDrrwUbUk9TWYOYHIyxnW2Mgo0/Wodo3afBYvKuh9suZZa/et9CaRg+7cYrG7hRQj5XT2sBz4MDqQsTqhayGKp0MQcg2VdD1SBxsGznYEoMMFiffUlyp6ryCqfo9rjN9SB09YK3W8X9MhXIhkAEcAdwcVkgzM+q1/8mzI8QweAPQcZl1cFlFKgV4JtsjG+Z2RsYZbPhLWgPlzDwxCtMVKjdDxCVqLZJQpYF2KXzThlptAdjxmh6PuNP+tlf7nX4PMZAhgIIeLlI20nUL+ZyTNM8/Z/+mYEaUPduUi7weoR1c=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4935247c-4c94-4fd2-3f0b-08d81e96a922
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:46:10.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBECmXvnd7s7CIEIxJyQtYPBGSE40h3czSGSfRNKfx4YXQGbav4uC1Y2ravRVcdi38tQ+C4+W4TrCnMiuPtxdZA2+oN3VnoJ1tpydvMS+wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3276
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02.07.20 16:25, Mark Brown wrote:
> On Thu, Jul 02, 2020 at 04:18:46PM +0200, Schrempf Frieder wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Allow external SPI ports on Kontron boards to use the spidev driver.
> 
> I'd have expected this to require loading a DT overlay for whatever's
> attached?

My intention is to use the spidev driver in the default board DT for an 
interface that is routed to an extension connector and has no dedicated 
slave device attached onboard. So users can attach sensors, etc. with
userspace drivers without touching the kernel or DT.

See https://patchwork.kernel.org/patch/11639075/ for the boards DT.
