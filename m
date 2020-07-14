Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E521EBEA
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgGNIyV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 04:54:21 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com ([40.107.5.102]:4735
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgGNIyU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 04:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLaT5oAB+ms7we7zRnqHKj7EiV1fZ9lLjwI0DpcEtW88hsnPLL/WrRJiqLHfGwn54vD10HpwSzN0jLyvuJpr7ucaP2LYb/p9j3I+mbIzEtS3TgZcVRAulTWuD6vDgSDj/cboLjV7VSczUGMr/pCOHZzTsH/kdWphEpRksxuLYTaFCaywM3Kg9gbmky0eKU0kLLi/mYjyyCRF+qabR5oX9erwn/XiueFvB3Hk4qS+c7dhmXtrZQtrBmsRbgZefi+HIaHsvyZa/UAbugb8iJj2Y6GIT4oXS9zL1XNN1AaP4ADhcxZLScmAsoKANC2eJQmRN6w17GFSZwtzMdgbyuLwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmZ5uvhsE5MPtS8wLfI0Bjgd/yVrSq5Ty7YxNLyU2jA=;
 b=EBPfIQYgwVQgkTfDU00RzaQUBzgQ01xvoTR8ClouFxRgFWwQt6lGoN21gSyE+lXuxqXw+TKnCg8n9xYIJXsBUj7X36jnHfp786TvfMEME+gj554pU2J4GD3BHc5g+Nue2PeHl8Nf7PIPCLSaK43TOb84NzWWD+fBo21vdHZPCuPQc8uKZLY4+qjveJfAatTOnjpxOOjANMeNmst8WlPxemMce+mXvVk5NKCCgSnycJAICGniKPMCVhegww+p0tMcwvRAyCD/y+dMsoMeDHRqDoLurJr75h5NRjzPYF40j0sRyO0ghHs/LqgP0AfrqsXcnp5NUPHbp/6zXmUEgyzdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmZ5uvhsE5MPtS8wLfI0Bjgd/yVrSq5Ty7YxNLyU2jA=;
 b=ROgzE/YYmI5iRNjGrRUKPqcc4nkt+yMuDXpn+cjGD0yIO45UMs31oGPGcvQW14qQJtMbhmwxaa7JyL+tOgPSQhINREe26uaObrf406I9pczAK85bKgslDhfaAXO+/cg8gd4CGCAZE/zB0rTpn9uHELn2P2D40vdpjfkvfMF33IM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 08:54:17 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 08:54:17 +0000
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
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
Date:   Tue, 14 Jul 2020 10:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200713151108.GB4420@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0079.eurprd02.prod.outlook.com
 (2603:10a6:208:154::20) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.63] (80.147.118.32) by AM0PR02CA0079.eurprd02.prod.outlook.com (2603:10a6:208:154::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Tue, 14 Jul 2020 08:54:17 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3aa5c4-18ac-4b1c-63ed-08d827d37da3
X-MS-TrafficTypeDiagnostic: DB8PR10MB3276:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3276A0E7469D2B7B3EB3EE02E9610@DB8PR10MB3276.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEHLnSkWVVqsd2xtM410UnhALVl9RPQA3dAVb0E5f++GZJY4aXBL3EIIyEnXtP+4uzjZV6hOXhe/d4fhF1vGPThz7swES1VeAkREzRLuDWKtzs+blk9I4h32YeNAPqAIPhUsI68k4G/NcfE9x9b1+OQ1R53oRFxAyFA3ioKGA/2x6oN3U/PaJAqebBNvXYjE8CGjPJ/8zAFMpmjuZVHnPnr74VKJPToLklBvz3n2ESBAw2PGeskCd5fuolCU2kdXg4tyweGsSOqGPIq/tqZgpS18B73AgZOH/wS1MUaUldkn5A7DQeQUvXUxbRay9gjQSB5WmziD2jB7i0JmVNjEKkuolzaL2rSoSQJHNPNLrskhAJ2Ck1/6N4rmwo4T4s4l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(86362001)(5660300002)(53546011)(478600001)(31696002)(52116002)(6916009)(8936002)(36756003)(26005)(66946007)(31686004)(66476007)(66556008)(8676002)(956004)(2906002)(16576012)(2616005)(186003)(44832011)(316002)(4326008)(16526019)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6YYE6bwsWAc1g48CZYSW39kOwi9MBrsvUU+Y/zG+XO0m9krhLYJpt9DZdeuI/JvPMQCGjnBRVgSClGIQecGeqow6sm9XYn7w0ksAEvvsmvvtfJN0rmbcZFsc/LO4m1aap0zx+VB2YEK8VoNEfCXICQQyXtgEvo/TMWB11r8iQImcL3hqglRt9G9B+jgI6AMqN54HgTnTEcgDbGPdreD/joumI5uGMZuenfmZK2qBIyRM3Uw99dvQw+ATeLZLGZ/3KZ/Mr5ihi68t4KDXKWQKTi+FalDQfVHCWO7w91SL2aK3G4WiXruwNP2fEEwUfWUsShCX1IPRHtZvqz9pMTrsUgN8+F7fYyxU01m9uB5GKDZsQnCTmTwO6pQ2+2r6LlARBBb4Od+Nmf2a45YxT9WWJQ8QIhYcBX4icyIlKzo//BhJWQrTbv0o4Q6zt1goiqGL0Mfk3RBKjRSN8WhfZdJ91g9Vnr+lfUiFz9/4hj9z/ns=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3aa5c4-18ac-4b1c-63ed-08d827d37da3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:54:17.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4JVprxkDccXSTUcrXodhzOw3XXA7s0QYgKUGzOUNelIyAim9Nc5YKVlwfOkvD35b1qhrT550/gJwFHOzE8puNojulOwOOEacJK7lpwgqgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3276
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13.07.20 17:11, Mark Brown wrote:
> On Mon, Jul 13, 2020 at 03:19:52PM +0200, Frieder Schrempf wrote:
> 
>> I would have expected that there is some kind of existing userspace API to
>> load an overlay manually, but it seems like there isn't!?
> 
>> So what's the reasoning behind this? How can I solve this in a
>> mainline-compliant way, meaning without either keeping downstream patches to
>> bind spidev to my device or writing and maintaining code that does the
>> overlay loading?
> 
> Basically the reasoning is that nobody's done it rather than any grand
> design not to do it.  There's some issues for more complex connectors
> present on multiple boards with mapping the same connector onto multiple
> boards where a resource on the connector might be provided by different
> things on the base board so it's not quite as trivial for them as it
> should be.

Ok, thanks. I'm afraid I'm currently not in the position to work on any 
generic solution to leverage the loading of DT overlays from userspace.

It would still be quite nice to benefit from the flexibility of DT 
overlays not only for the SPI use case. But before I come up with any 
custom solution, for now I will rather have the device in the DT statically.

I just wonder if I need to keep the DT node for the device in a separate 
patch in our own tree, or if a node with a custom compatible string like 
for example "kontron,user-spi" would be accepted upstream, without a 
matching driver?
