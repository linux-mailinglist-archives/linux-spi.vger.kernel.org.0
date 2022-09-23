Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492775E7BA6
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWNTg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIWNTf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 09:19:35 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F7958E
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 06:19:33 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NAkAKX024560
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 09:19:33 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3jqwb3ft9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 09:19:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3AFE5JgWDIxfgtVgRqlg11eAiSjfE5xnkAt0GGa13FU4BiOn1JfYnrMOF2Za9qDtMGYtXOsF1fNv48lSUg1ot69p5HJUE85SbGqTLxGbdMoe57iJ6yBeCKKZ+6+vwxFTGxcLS1YwwXsmHRlJRVtxzeyK2wFStEqnFP8yFU+1M2HXa3WNxJI22V9SYJtvlWhlS0TqSUKbcWT7OlSdew3DT7yTdBODsDar19zXVnz4ViUdJF0JYoCSY1MmTnnB/aTVlrnyfI3vOzSeaHIOVD6ZV7prf3iRR6JkYZZH/dsNGRgNBQKg7g6T0+DMptJctsfn6I8VXcPYNJd12yE5vq+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poh+BHMqZ9skI6R32nq8uC/pBfuW617Mmbw7ec/2vcE=;
 b=LaqFaHONDGZGLZt9umOzk2d0mVtwq3d9z3e5hXC+NPfj8WDfan1f+26TNFteKXOEl8nIyl2UJ0AOaBDEg7K1tUYYHKwQErjTnF+SyZVfuu0mFaxGy1Cmf93svsYy3Ge9C49SrlMkRNiYRUWaa2X7uyOPvVzOq9Kawo+TyKH4n4GCxdI1IbpJoTwUEAKHsYiGderOTCJVvuC8rZUy0dDB6TvWs6j1pBwYpgGG3Ey3xz8qfQsdvT/fBMdVTEI5G5Wg/Hypbu62JrK4Sm8T61RxMRNHSZ8ukLKuNbKN9t5IwvfYtPcZGEW271u3G9ODGGgFEhk3P1Nq2RUbex1bXIDd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poh+BHMqZ9skI6R32nq8uC/pBfuW617Mmbw7ec/2vcE=;
 b=fvruoc7BDgL75jetQ2eib+Mxiv4dje8xdRhtgrfkx0x7ZVELKMeSPzO8v5T3A1rCwK17ZSEJAERl5/OL1feYg/ruVzZrlvW6hDlVqHTNQsImrcYrrQ3QG7WWCzsDqnz/jJGeUDQojzHfd4PqfPsZYpzqdbu5dF06YvA+Va1W73c=
Received: from BYAPR03MB4647.namprd03.prod.outlook.com (2603:10b6:a03:12e::16)
 by DM6PR03MB5114.namprd03.prod.outlook.com (2603:10b6:5:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:19:30 +0000
Received: from BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::cb47:4e1b:d299:d2d7]) by BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::cb47:4e1b:d299:d2d7%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:19:30 +0000
From:   "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Extended functionality for SPI core  
Thread-Topic: Extended functionality for SPI core  
Thread-Index: AdjPTqMI8B9mcvurSSqTgmc9bLv7cg==
Date:   Fri, 23 Sep 2022 13:19:30 +0000
Message-ID: <BYAPR03MB4647C7EDED64D71F7729731297519@BYAPR03MB4647.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2hlZ2JlbGlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0xOTRjMWZkMC0zYjQyLTExZWQtYjZhOC00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcMTk0YzFmZDEtM2I0Mi0xMWVkLWI2YTgtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxMjcwIiB0PSIxMzMwODQxMjY2MTM0?=
 =?us-ascii?Q?NjQzMDMiIGg9ImZrbmJkOU9ySmFXdlZ2MG5PRUVQbkFCZVV2ND0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RHY1QW5jVHMvWUFiNDY3OE0vdEY0VHZqcnZ3eiswWGhNREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB4647:EE_|DM6PR03MB5114:EE_
x-ms-office365-filtering-correlation-id: 0ca6a738-0249-49cb-c467-08da9d663f9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93/r5Ag6U/iifi3Ie6gV1gZjThuHIEyUfZEFYdoIuHaGIoAKS/oiBNra7WY5Jlir5YjPQKMSsYJgy8okIShfa6vTRgNGUcq3Ns6TrMHlxGJZwPTBceT1TNh0B432vVzmTfLwn14KlGlbIO3jLxQYlWV5a4+YLREg5y0fvQ0pehKQrMNuMZWC6qyUfMbaiARJDMhWKlVOGqGcwxkwXOjYVCZqD9/MFCsRQW3DWskkQzO5upHpEWnUvsxzExIfvAY9KrukUZ5goOoiLLN1/h4nEM6f2EGkDh5KkuGjxz3PINeWTq0slLSZFeHAq4BK7H81/ij/Bl8HHI5/rqs9/efqbWqOojDBV9dTcZoqiVGhJbvJ5MVdYJZip9yZ6PjQWoBzKmCpeaFYRgsdgmIHqfCsagxdJE39PtgfZjeEFJu7Kt2IFwA1ea9bn941CCG9xVCKPC5JYLOJfhffRC0dM7SoOL5ukw4/k2nuCg1arctzyaH2zgE+kno/alX6laheXnDJ4yaKrqd2z4hXQ9ocG8yOq7jwJdGZjoALDczyzGhwbEQaa/UY3gtRqSBYrB4Xd/6FlqN2RLS5fnHqx9z8p7GkvRLAYohCkqZiSb/s0kovkRRyWlKxfcfdIeuOgqfiVUSRkUsztod+p0E5bjfYTbzH7BUd6+S/e09aXLD0OwuH+MEd82qQsz+d6sxOJNWvZ9zY/WG+fyxZX7GEhPyZtkbAxy4nW//MPT/WMEraftkgbwDBt7IUI+F9jGAnzNc6MVUvvQ2alzhD68hP2m5rxuyqcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4647.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(52536014)(186003)(41300700001)(26005)(9686003)(2906002)(7696005)(6506007)(5660300002)(8936002)(55016003)(38100700002)(38070700005)(122000001)(86362001)(33656002)(478600001)(316002)(8676002)(64756008)(6916009)(66446008)(66946007)(71200400001)(66556008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXaIGjYLX8B02nFgxg7hpI+78YFjKLsJnqp134Vfdl+pbaICEB2+IU3X/W7A?=
 =?us-ascii?Q?LRf8t35lttFJ8vYSvVMd77NFW412jBM7jaA14TQmpA2Ar+qroFrOX8Vdngyo?=
 =?us-ascii?Q?ykycWlGgmCGoojqseIyIvJGKKCWqH0GIwDjd3/+5nkD5Wlqlge6t3ykutDll?=
 =?us-ascii?Q?URR+MJTYqurdffNpMzpIjYWbR608N+75gNy73VG0qD1L4eAq5lCVP7h5MVCL?=
 =?us-ascii?Q?FXsi27w+1QMafaKvn6mpH5J/aebSqsgK1D7PMaYNCV3oAbgm5N2ytZnr6J1A?=
 =?us-ascii?Q?kgzGAyTSXZytlB8wHum5dOT36baS/SVjrTUaGz2pad9TEarNjIEE7o/x+HWA?=
 =?us-ascii?Q?wTfmA4Fd0tss6SXAcyayrEWtTmi80DZh9OmuHYr5Go/LFSic7dUWpZkn/Vwn?=
 =?us-ascii?Q?rP6dhW1CxPQAqOn++Ela1P+owpb9UlKO3xTHJ4BhLsS28Cvdq+npfNCYzj9r?=
 =?us-ascii?Q?WYdN2tDo/f5UgMp75UO/hg8A7clLzL74O8UrRgDzc9PL3D6sZ1OuF2Iktnzm?=
 =?us-ascii?Q?L7mtuFdeK8wMSUPjkRutrn27PZeAU/ySFP1v5Ob/L6yt9ydiIwS3syjpdLdl?=
 =?us-ascii?Q?aK5uOGDL+MZ8ltphImodmfbf+DrrwvQif66iJVmDUQiCn0l/RFoNPC1mX67a?=
 =?us-ascii?Q?3460ehuzMPx9N+f/jpNp4a0qmP+LV+Q66f2KmUYiN7MWBkcWZxcfX7nGkQ2f?=
 =?us-ascii?Q?iylwSxwGC/5J+uDGehsDF2AhJa74X5nA5t+aXkmokNLGLThvgKZAFJ4VPFVf?=
 =?us-ascii?Q?QIyj6PeyFPcDcXyEiHhd6z865hDMXLXX0mZ5hjAoXDDxhLDq/z9x1MkiV/Zr?=
 =?us-ascii?Q?/O+0S3hivzqc/2mfMGPvrwGwbQqSNuBx0n/OI3gSGpaIk72pL/PzfcMj771v?=
 =?us-ascii?Q?ejwD7EMorKtU77JrOY5THYrVcP4dDkvHJl6bjuOv5AtCU68B3k71qCMem2jN?=
 =?us-ascii?Q?qUnkjNfa37/qUhPSF0gw3RltedaNrRSBvwgvTqgLUGkcz5M+ZFg3XFOiCh6F?=
 =?us-ascii?Q?kRzs+4ZCaa7FghmwfekPv2vNLb5KW7djVvcPZMnLy+aC5C4ETbn0VlcZElMN?=
 =?us-ascii?Q?msELUEjYGZ2ZhKzt/17mQdDsOGlel49bQTeLlr/QCbFQ/r191Iwj2ln6jsaX?=
 =?us-ascii?Q?mfff8A4ny+Mq7iFxIk0xX9PQbfpBfAgwioP44RdNNEhFWNvQWdIqk2oYVtNV?=
 =?us-ascii?Q?K2a9Nmk1OHYhYggGODUm2zk28m+kg7Ir9HAwKaDT6NswnzSvr1r/vWcDzsjU?=
 =?us-ascii?Q?/BLE1CBcplPlHIknS0SEeIdIGCTsZyhY1sUUZ8w8pz2Bip58R9DSHCkJAD4K?=
 =?us-ascii?Q?uFVC01D4cgusUd/STOJLgYmpMjDF7tQNJqCdAobIPGYKc3sZWtC8eiB8wpzx?=
 =?us-ascii?Q?cbKt+supcBHoorDyJfEst6sg6gqcIxD8hSk+kKrTcquR/NgvK2glh8a6xm9j?=
 =?us-ascii?Q?qNyH9Yr7dfkcgqySYJsFL4h0kQ10KwSXca3RDA9pd/SB8FPswI5VB1FsdViC?=
 =?us-ascii?Q?BaYGlprHX3bgfhE3AMW1Q2d8yLgIwiZxlwuALUqc8/uFEqvuLZz4kLF5c9ao?=
 =?us-ascii?Q?VIF9tBQwc2lLlCnssSRuD+1gVNBXaJflRVBheIOy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4647.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6a738-0249-49cb-c467-08da9d663f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 13:19:30.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22YytnhKgjoOyzqA74dWC4N5JYtOPetY7pM1FnAFFbH0Ip3ybM6vfic9cKRzOZhHwkD5xu6awB91u6mWzxdlgn/lti9ouFIIIC9g5IpPlHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5114
X-Proofpoint-ORIG-GUID: HGtByypkY-hglUQ36enTWuneCCCdY-0D
X-Proofpoint-GUID: HGtByypkY-hglUQ36enTWuneCCCdY-0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=371
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230086
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I am currently extending the functionality of a SPI driver for a HDL based =
IP core.
The new features will include QSPI functionality and DDR capabilities, for =
an ADC.
My question is regarding the DDR functionality; the ADC expects only the da=
ta to=20
be transmitted using both edges while the register address will be on a sin=
gle rate
transmission. As I am extending the feature set of the SPI core I would lik=
e to maintain=20
backwards compatibility to what we already have implemented using the linux=
-spi
framework.

I think that the easiest way to achieve this would be to somehow pass the i=
nformation
using the spi_transfer structure, using a flag in which I would specify if =
the particular=20
transfer is DDR or not. The structure however does not support this functio=
nality.

As this is probably not the only feature that the IP core will probably hav=
e in future=20
development, I'm curious if there is a way of passing new flags/variables/s=
tructure=20
attributes using the current SPI framework? Or what would be the correct wa=
y to
include the extended functionality of the SPI core if there are no mechanis=
ms for
it in the current linux-spi framework?

Regards,
Ciprian Hegbeli
