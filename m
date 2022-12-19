Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D913C651421
	for <lists+linux-spi@lfdr.de>; Mon, 19 Dec 2022 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLSUly (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Dec 2022 15:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiLSUlx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Dec 2022 15:41:53 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2A635E
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 12:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeEg8ihZUrJReTRZXw87ZDa70EijX8CY2Zp1ylPlZuQ7b4ITsyNDow8800ti1s4J/9tAdtmChNCSzL6YY5ECM4PbmlQLArzWVVMX9WRDCI+TOp+TgJGWLVxeIhs8URsAqpi17s37Pq2rKsu2foxCFbbNRpu6H8OME4a58SBsjN9H5xHCIW4gTh8ehx9OYAgEKERlkrhcr6zSZANYretdGmqTJHjjn97zO4b4i7Ky6aLXQlHRvZd/FQ+UozRwY05NGEiwEYF5S2Whvd/hAIQ4aEo0tnFoJ0r8J6WBRPywtfsefmOOtUlorrzK4FnZlMmd22r7NvHB7i+EfGR1CYl/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZiiiwCn1avg5agYUOlNjNoGZNNlZVMc+F0Qr+CM31E=;
 b=Ncr/ENTg/N+YS6XoBcF/nYSvL1wOH5L4a+1HIx0kV4KZjEgsZumDbdnBdSJNz3XiX99gNRI8zxD8jpOcQmcFQgInK4ZssyLj/GuLRi07RypQQbXd/hyEEAOP2GJvORSjA3AAwyKEWwPdtou+kDjFwYClcaNTemPp6obC+xrRhnYxGHTdeDMfEtfllTl4ndc57jbFh9KPwgpFNKdeR3YxCw6jpFcWNg3tuYcsoPn9uaAAOWVxCg2hzJW0jWVC4RiCAiE6OlhDV8pi1ULUU0R5E1tcxQ50VoiNUokHF42OV8ufFiXz3ZUQMr5zGtGyF8X29HVjIBl0JFwfoGJKYPltgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZiiiwCn1avg5agYUOlNjNoGZNNlZVMc+F0Qr+CM31E=;
 b=hemuWnEbkh5pkEk/UsKWzgGS1lJEV2pCHjmsD4B+GmsPQQy0Yru3luoa2UkzwtcjTXkqjjT9bG/KsaIAOdOAWYYOSK5qBrBPbwX3ItrjlvrkwHJdsSq1eQ+YpUj7jO0afksjs4kI4oB7i8WWuoBKVNfz1AxrW8wc22O9Hf+O9ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS8PR04MB7528.eurprd04.prod.outlook.com (2603:10a6:20b:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 20:41:48 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 20:41:48 +0000
Date:   Mon, 19 Dec 2022 14:41:40 -0600
From:   Han Xu <han.xu@nxp.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: DMA support for FlexSPI driver
Message-ID: <20221219204140.ppbgpgze25jvuxxh@umbrella>
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella>
 <7c42628489ab90b545a8d86ba2e46696@walle.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c42628489ab90b545a8d86ba2e46696@walle.cc>
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AS8PR04MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2c72d9-0380-4856-2655-08dae2017303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNCxeJ7gxIFW4Ytm3QNYh+Mxf4K4gXNlchB7HbQHx6C+VGIler54qeAtnKojQhk2XSKApRta7KNptKup9ng+z0z7rmXMS9sET6wW4GsqMDvk4WUkXMBe936qlqPUxv8sDniLC812NXm6z8k4wgFx5iwILhIB/ErUrYpuQheTl29Y7DauX+CuFso6bcrYnPlq9/dZGRd1xC43m1wAOccEOLSRVMBiCiEj0lToDnaa/9rcRVvVWcOZpuXdN+NDm9sRdgx5cfgJMYrGQ8ZdFbY5zHtS5LIg5yK/ULqyejtrfy954ugBg6PKcTRhAsfhNCmX7z00Xi0eiH6VtwDBCECiiqNQOLx8i4BC9cSFYEgr2c/4WlDsIrisiCm1VDoTu8B0m1QgiDrA+23/VIVfJMEVVYgFgD/Lsudm7fv7xRvM1aqgnSSh7GmRSinMTsjC931c+kIf4fysrovx4G+ggJ07NZ9fZiwoNAT78OQHCBVLD0nTIHIaRAPoV/raCbno456I8N7l07k4ulLE6ducreYEDoEgvnrUYX51q+z2A6K28O6AzttqfmdLCGn21sx08u8obrchUEruZo5wKIrR3ZvVnBlyo0b212V4G0VszwmTsDcIX08RBUg3cSosbC0A5DG9fkdrVtyUj5p/uZXpdriGdWknvI8+rJSfmPn48aJgDNt1mXgOprf3FI+dGnSD0N/Wwf4JDCpkRQxi5CC91wyZiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(38100700002)(41300700001)(8936002)(38350700002)(66476007)(66946007)(5660300002)(4326008)(8676002)(66556008)(33716001)(478600001)(52116002)(83380400001)(6486002)(54906003)(6916009)(44832011)(4001150100001)(2906002)(316002)(26005)(186003)(6512007)(9686003)(86362001)(6666004)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJVIDywFpz3bVdpVWF1eHAqNF4XOzd3p8PREkYX8qDxLg1EKr69rrkdYtSV+?=
 =?us-ascii?Q?ZwS7Af415JsAwgJNlDnIvdnNiJko7dPTM3vyuKdqI7E6P0JXyRJjbuZNoILD?=
 =?us-ascii?Q?IB7PZ3PUVOh1kQDf64WghDiG9ngoX7b2NhYxIc7RRvKyEYMkoc35hrJL4SnJ?=
 =?us-ascii?Q?hMVdaZa5FYQAjqFQYvo0Qy2BZMTHphig1mq/IAqW4SzImZZBi60glgm0r5NA?=
 =?us-ascii?Q?54frDsSTTHbBqOs+nxO1cO1GAAEUtajJSK8/H4qTJ+i+G8jUifmOGBB6wWNd?=
 =?us-ascii?Q?4elyb/3Rejn31PoVtnbP+xuYpIG24jx99pKkjSgVdmKWkYbqd/xgUP61rfsu?=
 =?us-ascii?Q?V49l2xMq5v89HBp3UnnmOIf3TYaCcnPxX8YvZ5sbiJ7X4JutSdEeRQiX4nap?=
 =?us-ascii?Q?EI9mT/jve3i6/ya6hJT6V8k7MNFons/SkxBEnVOuSagM0zOwDG8Qz+kqA05T?=
 =?us-ascii?Q?V5+Brz+OSbaYV4SU5rXRbZb+sZe+m5k1nGhLOLSHpTlbMv1rHvELtiwoPWFM?=
 =?us-ascii?Q?2rvw2G4BTyV+ULNDI+wHBP+IyCaAsm/ARqWCF/BOAQL2g0P7w+Cy6ZlDAdNx?=
 =?us-ascii?Q?kW74gd62f+4zIWySgzIXDzUXn7Zu/iL8/dK8Go6zQFqubFKenZkvVuFOxXoB?=
 =?us-ascii?Q?bWM8JYkEQREMxj/oQtS/vmS9PyKLc5IiLZazcLWWtll6qmtGTYCgKY0KbAbp?=
 =?us-ascii?Q?MhZnpEtrsfH9hWNpfmJKg88wv2JX7N/cqtVLRfTWnzZhoAK1E4N+s3F3qkBM?=
 =?us-ascii?Q?WZQfoxEXf373hUA4y7rkGnszC8VkirSVMdC+fYD0akb/RKoURAphiCnYSKQ5?=
 =?us-ascii?Q?abUwKKabfcl28HPUcM0sc/6RA5OuZ5FoM+tvr4ppIWz3Nfpx0/WTnZS/Tj74?=
 =?us-ascii?Q?GRZxRH1o7dx2zd8aCqnAqdbPs2ToVDMyTlMt4Jd3BtKkCNjCHtDUX1XsnoZ9?=
 =?us-ascii?Q?8e3yGzmE/5flRPgDniaRV4Byz9PpXdXdEdOtCuZSN4trkCffPolFciqamgvx?=
 =?us-ascii?Q?rpMdD6oFPEO2fCagK3ub8UHvIhCQPEceMSu5AhRQJgReBK+B3V7l0wP/H/97?=
 =?us-ascii?Q?aHCIgjxOoOPTzL0rcfSIQ5c7jHNnEZfeROD4pLFvKeWoxIWs1E7UVfGKDway?=
 =?us-ascii?Q?H0syf90TN7XepvbiKY+seIan55m4x2DWE+ffllcDtTeLgfngOgcGp08fZ9GI?=
 =?us-ascii?Q?xoK+4x0SWnV+mrnItp5eHDYiu1u8t1HTdNOcTCMdQBwjzo6xaLBL10PHdJHD?=
 =?us-ascii?Q?PNPW7Y+gMJ3cT96T0mXdTSimnVFpJipPgHO79EXvwwnYpvvAGRWL0MiSOmNs?=
 =?us-ascii?Q?QAaILgEOtAhtPUAywGp1JVgX/sa5jGgOOIKIitopGCxLvVd1hG1jsNHRNKeW?=
 =?us-ascii?Q?cxYXmuDr0BNnKUbVaUkQaJIUA1339pPfPICCKYy6sKyXCyydHCYtlT+qg1+I?=
 =?us-ascii?Q?RL1TQPuSK25H2lLEQogKXx/FZ73sK/NGQe5wP1Z6uXXFjfTiDS5L2bNpZOXb?=
 =?us-ascii?Q?BEqvkIFiT0DVNXE1n9a9JmI2vsvd2X00KlQYWcmt/gbObMM6dFcTQFdMWEcX?=
 =?us-ascii?Q?C+M8MH4/mw2l6sU3qj4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2c72d9-0380-4856-2655-08dae2017303
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 20:41:48.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KGD2RS2auIFQkAj2qh2lOG8uaheynhrZFvoxZ3jFe5tPynZfVqcEpTaPldvn5ot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/12/19 09:21PM, Michael Walle wrote:
> [+ Frieder and Boris]
> 
> Hi,
> 
> Am 2022-12-19 21:09, schrieb Han Xu:
> > On 22/12/19 02:08PM, Fabio Estevam wrote:
> > > Hi,
> > > 
> > > Currently, there is no DMA support for the
> > > drivers/spi/spi-nxp-fspi.c driver.
> > > 
> > > Is there a technical reason that prevents DMA to be used on this
> > > driver with the i.MX8MM?
> > > 
> > > Also checked the NXP vendor driver, but DMA support is also missing.
> > > 
> > > Does anyone know more about the reason for this?
> 
> flexspi is a copy of the spi-fsl-qspi driver and I'd say the
> latter just got the basic operations polled IO or the memory
> mapped access and nobody cared :)
> 
> > We are working on that, both flexspi driver and sdma driver need to be
> > updated,
> > and will upstream all once done.
> 
> Are you also working on the DMA support for the layerscape
> architecture which is using eDMA?

Yes, we will update qspi driver as well, it's almost same as the fspi one. But
almost everyone is on vacation in these two weeks, it probably can be done as
early as in Jan.

> 
> -michael
