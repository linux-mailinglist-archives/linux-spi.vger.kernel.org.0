Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA23B670D17
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jan 2023 00:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjAQXSW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Jan 2023 18:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAQXR7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Jan 2023 18:17:59 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440E5355E;
        Tue, 17 Jan 2023 13:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q57KGRucO4mnMk+sVIZlPw9UmZaz8Cg14bCD2M6i0X/HtD5B6RmW9w+rUg4ErNU7a9ILQ66sSiIF3nbruUwEG7wxygR7lHGVP9+Q060n+yVfssaWklgyejW5eKAJiADcPWlcVrGMU/vxKEEZegX1vpY3J4vwi4pBTYFubYnb8t9kY9xHcw0z5Pjp8TmE6aVJ1JY1uZYWue3Ua/RDIY8vNcooLjV8sMXySzu2lugH0hbY+NIMKrifjsCekEqJdzYr2TTvfvyK8eP4UdQlOPrdydGyTKcCo8wyTmEifuaOJdaD9GEXF8sd44syWaeVnqZ4ilIMv9NExqYQPJ6tp8aOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIdo5ddQr5jY9F8m7pFltAla+p6d6pdzJwMEwJNeDCM=;
 b=MkiA9PvaOYUQhf2Ywl2TbSL60o8zwiG7YyTxPTOCewjq7ASnEfripmGTtfHCBLaVJ6oK87+3ggaWrNk2Oess5rHiXNrWZbFNOWZOZUrWOM7Te+LRM18PWsZs6J7D2J1Aq6GIWQWmAqU4700EqxXpAqXNQzhtFBxgw6UzdHggX91I/qpk3EHf1pTaSVlfDcH6wFwYZNQRTnz76OrvetINXMW+K6iCeWtaiAHzk9jOpJYfoXzNl8/DCZff9Zdbt65BzKpz8pMtT+jjp+yHy5FRaEZh/aAhrMdScZEIe40PRBf45dnB9ANlc47fp1WbebQ/EjS3gP9GNhKtw4UBOOpXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIdo5ddQr5jY9F8m7pFltAla+p6d6pdzJwMEwJNeDCM=;
 b=BItabsL4kdOx1H8x+tT2WtVhLQ7pcq9Lo/by8etPrrZmSCaskkW6TqvpvWFQF4VaLYUVlu0YtzXnAIM6Ff1AvTz9WCvukxCJUMzY61Hzd8zPuzxNQe/rpppKm4m+JxnWi6jhoB0a/v3UkR7xf3hk4mghZDd6q13wF/riWFqXHk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 21:05:09 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::a5d6:dc79:e11d:c3f9]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::a5d6:dc79:e11d:c3f9%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 21:05:09 +0000
Date:   Tue, 17 Jan 2023 15:05:00 -0600
From:   "han.xu" <han.xu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mario Kicherer <dev@kicherer.org>, Rob Herring <robh@kernel.org>,
        linux-spi@vger.kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
Message-ID: <20230117210500.oimf4yjkkqh3o4hi@umbrella>
References: <20230116115050.2983406-1-dev@kicherer.org>
 <20230116115050.2983406-2-dev@kicherer.org>
 <20230117141057.GA2991740-robh@kernel.org>
 <85967a3fbce7051449f8d2b29ce5a47c@kicherer.org>
 <78fcf85f-b56b-79d1-f2fe-c038f424c72d@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fcf85f-b56b-79d1-f2fe-c038f424c72d@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::22) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|GV1PR04MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ee8d40-dc4e-449a-e95f-08daf8ce840e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEN4Tct8fHGAmyLHqzyFRIyyjEEPi538fHEoEd2wCucPRKtkq1QAGnBCGm7SvD3e4qxX7KTjsyxONx4wiJ9frO9gSJcc7hpCAH4SW78XLkUc1zB2icbfgupvIZGHEEy8bdpW5oh20GSpltUsxtB9eMMezU4U6LsF5lIOAOlYfGfBUFXViLyvBIqcJ81nMXVC3/PuTJGAajOnSazwqk6465DG4Z6PQWTUHE9gwuE+WVbdw68yLzK50UrcIGFhIVDIm/sDm82eaB9OgiGPowv9V/PPHPkoxdAB3Rgtqfqy6NB+0twiq1ev3ImairXe77PlWaUhwl79OlnOGsC3c8MmmwL1VRFYucGAJbQ1Gs4RZr8q+OkpWviaHo/UojnbesGQ6sPYI+bfhaPtgkHGcDNhcfwwcz7QtL/ywG2As21u2TyIkdyZ145jICmupYR+7VxbDnR4te5FZrJDToniV4ehZRw2H3mBk6o8y+mmPl7rEsdSiRj/b/CCtIRXBsSF0SIOUUYt8MNUCvzXAkZYq+6E2c7s6BptQxEgkr3W8GsXiXWwwI+MZQQM8mKH8PQQ/t4ddmzwjYXwRwUy/J7g0F6Rw3xCZJ//BKRMZG2UDkrBy8npvemvldGR962zpnjdtPX2OpKhn3W4oRYaYl3VMRQKJr9mZ4OBdBg8ELLhkbEkIE6/UDbVS9AbVvzIuVrz/fDOc7L1f7TE7F49/Qd3WuUWMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(86362001)(53546011)(6512007)(6916009)(9686003)(66946007)(186003)(26005)(41300700001)(4326008)(8676002)(66476007)(66556008)(52116002)(6666004)(316002)(2906002)(54906003)(1076003)(478600001)(38100700002)(4744005)(6506007)(6486002)(38350700002)(5660300002)(8936002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t/iOhK9H47AbS3w2c+8IXlxBCpRTsnzdcq6iXNbKU5zQ3CFmdRTmOC9wIKYC?=
 =?us-ascii?Q?iw4xLZZOCUyED6OKPcpTva66NodY/9KSdtmdA4AqaH3DGwykQYtfGYF9jjV3?=
 =?us-ascii?Q?r3rtXBI5ICml9FnbfuXJudk8uskof9pJOHCzrn3NHnliUZZOZx16XdpTDq+1?=
 =?us-ascii?Q?anRRbr0n0Ez4PhCpO61Dk6+9GEyB0Xr3lg3+HlIGbSF65o3DfEknCpYSXrPE?=
 =?us-ascii?Q?VJp82AIxpZLnPPX4ibnffLd57De5XZvOs2ydWAukqCJMsZLjEJP1Z58fdc/c?=
 =?us-ascii?Q?IRCoXcSaRN9I6LfgBq1i6uRTOI1sHEo2CRC2utA0OLk1WMhf6AZOdgSXwV3q?=
 =?us-ascii?Q?nsQ9uGtrrnbijDVBCrLIOCobQTqM+p4jZ//99xakhpsjcLaU07fwHSf36lza?=
 =?us-ascii?Q?Ygo+kLGHAzhDe3QEqsGlAbLsEn3fUB09omrAMypiXQmoLBlaxKTCo9AEKwuN?=
 =?us-ascii?Q?bz3YRgmbvoxgcrJzyJoRWt/GyNimih6mk91F2xbp45DXwbnWe0g0GlXpGqQe?=
 =?us-ascii?Q?KA9Pz4Z0tKG+b9CEXMO4Jn6WYiwTt/eEKgQS8EV5fS6exF1gA5OjchpNraFi?=
 =?us-ascii?Q?WXFkUIpx/0MebfJ0e9bpAQ4mLLt1vTGrASbvKbMgwfgdX5FrkIK6q18psHRR?=
 =?us-ascii?Q?w32yDcekA1JFz2Inb+uoqWowjNk/laOdvDpiTynPjvkZmyITJASNm7/i1hgo?=
 =?us-ascii?Q?O6EKyed44fd0JQvHO2/t/5MHYXhKeTKanrvNiOvlEntJQYzPsk8M5jvBRp5E?=
 =?us-ascii?Q?YOKli0+1CXePXf7hcLTXaQ1l/80dJpaMGOdv82XYdWanL1tuYg/Ve/ekAuwz?=
 =?us-ascii?Q?7mIxPwnw2WxK06NR8E0UOqQObOh6I5N1mLi45HD+47dPsV8j5jvJWrQVzuzY?=
 =?us-ascii?Q?ESJxLWvzfq6v2R8vJrB85+zxWm1ege/UtWkkpm0zQ56ZGe9lQ4Kn67FtIfsa?=
 =?us-ascii?Q?aGrRm4NCkIiJqKghLavCSiqzX1Sc724U8J966Gig46zp7fbs3boG+5KZFuoc?=
 =?us-ascii?Q?Igky1N/JTPcTcXF+AbxrHZeTTwKgU0OerhlZ+PPOANULFPLxibSXjbMzzbl+?=
 =?us-ascii?Q?YwxjXuSxgisgnlM/JABvszC3qoK+bez1fs0n2Rf8GaY/Q/Rdwu6pyQwAxcep?=
 =?us-ascii?Q?Rhs68rSJjyKmhsry0M/r4zAbeY24IPNY6hvO+JmxAIxCalSPzws9jdzzPMUx?=
 =?us-ascii?Q?C52nDlJpqqaZq8qqdk5nNfAf8PoXYqn9JX/wAyAJamnXN/9RY3BLjAckGYG3?=
 =?us-ascii?Q?A91D78O8Fv7HoOZ+NkWKhpcKXk/afak/4jTEJNIidMKxQuCRxX78X8Od3GvJ?=
 =?us-ascii?Q?2vS9Rwed6M4OYzBpijD2AW/F1Pn6OhaEJydrZLGYRplmcjR9Wm3nxZx+9l4h?=
 =?us-ascii?Q?XQZyXdXn/hytRLIAOo8CjPkG90Bhdq9YhXvWOGXOqUf5ZiVBw9egor3boZCQ?=
 =?us-ascii?Q?arWgb9OIr5jFEIgvzNa4mga6WPy3TZkvWg8aW5IvCOVZIyIa9kOdV5d9qoG4?=
 =?us-ascii?Q?jCJ/oAoJaPdsTklsVi/u8vVhL1P+lFQsBzs4+cgWn42BJP6A+X+nj0vvN8hU?=
 =?us-ascii?Q?V70piuK+TprdmElreg6gUrLYebM4VsCoZjwRMOAG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ee8d40-dc4e-449a-e95f-08daf8ce840e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:05:09.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWJ3gtXpbMiMM7ugXf5/QrYLVQhRqRAaKm00jxU1/bM2varGtNDcUuHh0baWsB1h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/01/17 06:10PM, Krzysztof Kozlowski wrote:
> On 17/01/2023 17:33, Mario Kicherer wrote:
> > Hello,
> > 
> > unfortunately, the rx-sample-delay-ns property does not fit here, as we 
> > can only delay
> > the sampling point between zero and three "half cycles" (or edges), not 
> > by an arbitrary
> > number of nanoseconds.
> 
> Why this is a problem for FSL but not for other platforms having exactly
> the same constraints/property?

Hi Mario,

Please use the common delay in DT and calculate to half cycle in driver, we have
the similar discussion before for fspi controller delay settings.

> 
> Best regards,
> Krzysztof
> 
