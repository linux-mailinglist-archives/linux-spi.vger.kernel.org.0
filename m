Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79529220624
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgGOH0f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 03:26:35 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:40384
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729283AbgGOH0f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 03:26:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiLHEYVfHMLN6w6soDJ7T0FttL6OwDlmIENNu5Gpc4kgA3WEjqCysvVCvi9MnXLguVvrUoOQM5ok3ryeOn25kk5L2OqcL0Dp4xbGKkstfJ/FflEuoHGuyGiaVs4kHCeX3FobPvrdpPgLsiXOSWxEJMjnxzwwRQ9GS/DaZZsvwLjULeNxPajjkR4JJrze/xEmKBjV3uRg4yK9nl/54WDrdFpc4rQDxMN8xRMPtBInNIhLQwEEjvvJlhmjEhlrzWx5JX/nO+0SISZ3Ugxc8biIdVvlG7FF4LBFppqOcMH+pDj01LdPSC6gnfB+9TEcYIVlNkjmZZ/sCRScCoXQnnYNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnunhXK7BmdUXfkEGB8BFFuOlWT46F78/xfRgN58jXQ=;
 b=CQm5mvbg4iukPaP82JbdKSM32XdoQbAsOW0ozAJJ00bBcgHIyotgAKXPIjmCFUhIZh9VVcwenK107plySAW8Ip1PBHv9+Qqi/AuRd9u7vp0zN7kKVO3toR/Z4A0taCVSNoPP8Ul4CbLydx1CNJumrbZ/WELJtAJqqj9nr8ybS0LqR4OBtdYDQ8F1XqYkIaARz/isAnEjewG9XTB+z4+w6s4PMHa9iKgunrzbRG8N8pRaWfF+QfpoEbInOrenA+iGblkqnDyMjPBIN5nqdgKYq7+Yg3nsJ+mchgNDBVuimAZ7GfAoxCAg2IeJ64ThCtDF45YUsfuhGWPFQHXiroE7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnunhXK7BmdUXfkEGB8BFFuOlWT46F78/xfRgN58jXQ=;
 b=bn1M78PEWN5JIehnBjXgPBKUADso+SnyZlsSt5vpdm20atlPIK0drK5TFL6WPKXarwz47jEo/cNiy/efRp8VtoA2NIEaEqkiNqWp1qBBl9xUyY5y8INbeHBZoKQWg1q8Cxvjd6qKIC652fj3a212h3CaqU6qP9bq8fXJmzFXvyQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB6PR1001MB0984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 07:26:30 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 07:26:30 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
 <20200714192907.GJ4900@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
Date:   Wed, 15 Jul 2020 09:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200714192907.GJ4900@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0080.eurprd03.prod.outlook.com
 (2603:10a6:208:69::21) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (109.250.128.36) by AM0PR03CA0080.eurprd03.prod.outlook.com (2603:10a6:208:69::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Wed, 15 Jul 2020 07:26:30 +0000
X-Originating-IP: [109.250.128.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c83a16-f50e-4765-ea85-08d8289064ea
X-MS-TrafficTypeDiagnostic: DB6PR1001MB0984:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB0984B70946C80D44C4752374E97E0@DB6PR1001MB0984.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 505f54hriWc64sBVpYU1kM/qapJi5WJH3Faz9YVgCjD5R6kF2B2O/rDV7sOfvkQGTB1HQtsEJn1gm15osDuC+C0K7Y09DL8dPa3cg7/vDLlJ2VRizr+gvwokAkU9J7ma8o385ez1aNjkE6h7OLILF7WohbElyeWoT+wXB2PCYCstfcERDKpTTmgSgpJ0GXgXntNmJcf5DcvF5KKKaZC1GqVtvo7/ZDECTswjEomRj+VC6WW0d1EtZIg9md8cFjZ8VaUNIWUNZssWajkcO0HctJWlYPh2r+Y8JlukEUe96YycU/xOooAzCjQy6pHAH6pD7sFvFKU25W6uXlxZWa3dDSAQ4azDSvnVlSKo9Bg98wjQ1WH/L9bgbFZULlpzcFub
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(366004)(316002)(16576012)(5660300002)(66556008)(66476007)(26005)(956004)(2616005)(2906002)(31686004)(83380400001)(53546011)(8676002)(4326008)(66946007)(8936002)(36756003)(16526019)(6486002)(478600001)(186003)(86362001)(44832011)(6916009)(31696002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: iCN1NspopIPfr3dBjsLi42tty/0gJ55VdrKSJF63QYReZT2tv9aK2c3o1kXWZJeb5vYn62nVWvNwWW0KzzOvrPxVFF6IkdjkZ7/zEd1zcWSe8kFWbNzNN3egHGVteUSUNjJxaxTFzFVx8VX9YuWB9iaW+QjbWvBJ81Uds20SjKyGl9bI3BanSRm8sp21eF7dr6Q/c0Yra7EsONrLPCoV2CpNwxDlI3OICtIv/rmi/9IkbL9DIysTI+HUDJpK1gGzEyZkJTONs8ym4P48s36YS7hI6Wb8bupTlaC2b8hGb6GF65RpGnE1nLYLv3dsouv7JLbY76lC46XMWpf/uMjuzqPa/90N+zqLfIT5XYda14EqjhDVgtwtbUNDXr5SFSbJyDAZrY+ubuwXlEFcT3daEqyBuEeQjS2IWIgs/VxvOBZjOAj+sUJoWcWd0l4NmVqUy79NwS5ti7SiFQ7DeOV4jPCnqOLf6aSyJSBPjJcZ5Gg=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c83a16-f50e-4765-ea85-08d8289064ea
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 07:26:30.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX3pMUu8kDHJu8Y7KZsTigHGNWR0yRylMi6YRXWQ+WjaMkBpbo6EJzhvcfVGadc5b8P2MnkJzqq2VG15kvjByHOq3xnLN9KPJvcLmxqvSoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB0984
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14.07.20 21:29, Mark Brown wrote:
> On Tue, Jul 14, 2020 at 10:54:15AM +0200, Frieder Schrempf wrote:
> 
>> It would still be quite nice to benefit from the flexibility of DT overlays
>> not only for the SPI use case. But before I come up with any custom
>> solution, for now I will rather have the device in the DT statically.
> 
>> I just wonder if I need to keep the DT node for the device in a separate
>> patch in our own tree, or if a node with a custom compatible string like for
>> example "kontron,user-spi" would be accepted upstream, without a matching
>> driver?
> 
> I'm having a hard time getting enthusiastic about it TBH - can you not
> just use spidev and live with the warning?

Ok, I can do that, but when I resend my patches and add "compatible = 
'spidev'" to my DT I expect someone to complain again as my DT does not 
describe the hardware.

Seeing that there are quite a few DTs that still do it like this, I 
probably will try it still and also keep a patch in our tree to remove 
the warning so customers won't be getting worried.

But for obvious reasons this can't be considered a good solution and it 
seems somewhat disturbing that the maintainer needs to propose it 
because of lack of proper solutions ;)
