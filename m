Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FD7DB4A5
	for <lists+linux-spi@lfdr.de>; Mon, 30 Oct 2023 08:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJ3H65 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Oct 2023 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjJ3H65 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Oct 2023 03:58:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4ECC4
        for <linux-spi@vger.kernel.org>; Mon, 30 Oct 2023 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698652734; x=1730188734;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0TmuEj6ctKBrD0pJb1dT8WCex++zuSCaHo4SF65AbfA=;
  b=IL8jn8AP9ma3/jW6fNRgWtsep/MNqd1tGmO3Q6daKBnMjfxd62UzaBlV
   nRzB6+DS3CedBSJQ7bGDhAvi67300A3OxsdS9f6PbbcORn9tDzEiGRbT6
   AkfjxqSDeYEKQwNKC1ulFjRImJShAquV2sVNipm7G/QhtfpsvLHpTEAWD
   XMM6XZjt4M0v+fha2jFpMoqFvZ1x5Hiw06mlUqR+E6Pi/cSVcoixO4JU/
   WtYMErvHDr/jMscua2dYbyWc0E4wPDi8XheNpZSYuD9L3P70DydKfP5LH
   E93t478EII7Nt+f3uO+cjm8j5FBTbVIsOP74ccI3KcqiA+a0d20uU5Ile
   Q==;
X-CSE-ConnectionGUID: CrGhrS1bS2ucpE+TjKqdVw==
X-CSE-MsgGUID: kybqsPfWS2i6po3+CqHp5w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="10891466"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 00:58:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 30 Oct 2023 00:58:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 30 Oct 2023 00:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk0A0t0ZTYT3LEnVDLBwRITg3vuHViyPEg1hHmkMWGlXCzpkgJO7dVdM5d0k/Jgl07csGeSx0/qbsfYyu12udZBM4QqWqzJIGJY3woPyKJ0HVqleMQAvQuZ+NCNFPnD07O82yX4rPnlVbBuN16WyZvQVAaLBnErmkIx8pKjuuUy8r7fAbsiY9ZPBTSW1ieTrXfN6t8M8zSO/vDCafVrAdMFKUESUMbSw2FzaKFBpC/lNlHHB5YOrcg9UBr4Vkv1mN9m3UL8nL5r125QN0klszeGebDRbUvRmCDwPv5ilLij9xFE6X0f4BqNMzUUQ/3lllsWbSeT2JgyFvQ5MySuFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljp0FaoRz8AcXKjaVUOIBKuDC0nZWqU4J/601uk3fik=;
 b=FhRJNbTEmbD/h02jM8sItdcFW94pwHN5755Wko2O6AihCVXGlv2AA6RlLUpxMIu5VemRCRmb701atuAaB0Rk/Uu3yvP7VZEDM3vlHjnPlPPxgZEjXtkGb9MQqYKmIPuA1TET/d+qB6Kl6xiA7R4nadLh/3iaqOuORB3r9y0nEFDGydZduhQATFjE3zM0Poryz/QrhM8rRZYp0lvErtJp2yD8ZdA2IecVVKz8hq7ekxT9DMYRdfy0Xc+NHJC6JyI04qKEU+x5+R3/L37+WFeYN+7/QCl+GrlXXscNpWynd/DLis2WMRCkJNp2EsK84PXYGrshtiywsWMZCzupjDrP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljp0FaoRz8AcXKjaVUOIBKuDC0nZWqU4J/601uk3fik=;
 b=Im8wIHeZoGy1kXJ7bKkizK6oZfW6m3OuQujhPQASrbwuB3E0L2IaJ1qYUrcjjxt6/V4dY+1v1IW9qlaTlYGrlBCeGBvl69GeF4QJuV359AmXTtQs+wNKRppVPXcjJiTzvISF+FLbGCPYO1EEHDwz4lbgshQPvdYjwuOanI17bPA=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 07:58:41 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::61ff:b693:5db5:f4c]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::61ff:b693:5db5:f4c%6]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 07:58:41 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <broonie@kernel.org>
Subject: [RFC] spi: pxa2xx Speed optimizations for small transfers
Thread-Topic: [RFC] spi: pxa2xx Speed optimizations for small transfers
Thread-Index: AdoIzME+QUM1M6f+TIm0Ggs48Kv/Pg==
Date:   Mon, 30 Oct 2023 07:58:41 +0000
Message-ID: <BL3PR11MB6484F9C881084E41E0DFF3A2FBA1A@BL3PR11MB6484.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SA0PR11MB4719:EE_
x-ms-office365-filtering-correlation-id: 5d1a6eb6-9afb-4389-f234-08dbd91e0835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdTmtyTKGvI0jdHyvzYpVjyaB4jr5iTuME3YzA46ViuwAiN95TRHF3k+TICvWZ7AjR8ZdqtpwiNnzbN3/82QiExP7ti6rt8BlOc1QKPT4SymtnldxSprjXH1ZMKU6SwpfjuvO3F/gzuSZnmzBRs+vVsAnvfxKVHP0D0M7Q1XW0i1BTXAFABbk+F3ecTiyZZAj0flkWGdmKiqQ4+sg4ONMNprd9YRXRjxPDTz6FHHE0hKHxSv/l74cBu8jxkruWFQ+w6DzAPUVCMVb6TbkLqt52Tz4oxla3xZZAdSNKbA0e4iDzJg0dfhjHOxryEioPdMSrG13xGfs6P/hCKBeEinCtKTUZ1cQXbGQOC7bPTJnhKLIZO1r6iUsKkRBhsraam8DT7j40nmzp5qwQWIddMADdH18HGsNtSxHijEc4DT6PnooZ/DrLBjekyJ/odcjSQHLuhvJRZRm06Yf+qHqKfgj2C9NEGDsDeIvrZR4N8l2DYdnRfSw/DiXssJE9pehOxDYNe39+HEychJ3bM6yJJviT/jQnYhsfMR6SonQZg9CEEZYXNmF+774bAd0VpT5bpQdTE7z4tKh5BmppkevvHsafdymHKFMZ2bHg+f9+4oYZ86oEOYwkqVzyjQ6V4oUyso7vHezpYojh6vP3zB0RwOtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(966005)(38100700002)(86362001)(71200400001)(478600001)(6506007)(7696005)(9686003)(41300700001)(8936002)(4326008)(8676002)(52536014)(5660300002)(83380400001)(26005)(38070700009)(2906002)(33656002)(66946007)(66556008)(76116006)(64756008)(66476007)(110136005)(316002)(54906003)(55016003)(66446008)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?deczlsPA0WVL3KIT4Ld+NuEIv7R+9sYiz1w5HgjcC9Ewo96cSLjbuYtA/y2I?=
 =?us-ascii?Q?ZyI2JOx9hx6MwHVtjb1Nx8RkklTfkDzK1FwPUkROfmNoNKDOX9f8JtegzVUR?=
 =?us-ascii?Q?3qMGkeVFnqeGUkyVlYg7djiG9aZMSCHe1+chW0bgTGPnMzs7BlfiyQJ+h1zc?=
 =?us-ascii?Q?eCpi59UT4QqmsulBYko+kKSOUKtJpCAKVfEJRwp16h4aWv3ANNy+TymApnbc?=
 =?us-ascii?Q?fvwKWFHWyaxV+7/U8Owx3ovQKMBZRuNpqQvO6QHA5vR9wRFLsf3t74Oj6bP5?=
 =?us-ascii?Q?3Nt3j0sgY/kvDQCoWrMffb0wdeOtmIOpuExMts+urUA9QDtfcirHOIAdcgJ5?=
 =?us-ascii?Q?QW2RZZCoQwxBY4qtg/jPxpAE7aHMS51q8DwsZyoKDc0xEbAIEK+xipypp/24?=
 =?us-ascii?Q?1VLx7hpQMknf/UkhvzDgZx+7E3bGtiixuc/24pNvUDXt9jJQNKTB4IEwPBdz?=
 =?us-ascii?Q?3/xHfMzfiO6jDGcN4ubHxEl7+1Nt6h2z9AhcQHmEWQruWp2rC0cHa8b9DmFV?=
 =?us-ascii?Q?MFkKYrUeq+jp7m2syE2fpclaYKDRSTCT6OdhZJK+IGGLZitm77Rj6XhujszY?=
 =?us-ascii?Q?CDMtjucEp5PlLRxej4pXiBeRDYPAK1iCtX2g5nhjt9610cPOMVwwzlBEjG3H?=
 =?us-ascii?Q?FKsxUBzO5V0EeS/9uSvXCB+04kVdeRIqWMWoKDETiGvwvd9/Piz0dcULDbr1?=
 =?us-ascii?Q?EJ9npwbU1StWy3PugQzJygi5zcDernxUbGIEzjbGj4qITwtbIZbnhcpETdBi?=
 =?us-ascii?Q?3IOjOyGq1IZ8NJu251xkm9YfOqE1u+W7DYqpo/o9Ut6P465D5rFLbpmheBsg?=
 =?us-ascii?Q?0ETTWlGwLVqceuxUqTJmNxjVCMfK4pwhzZ82HI7YSDEBboSQ8z/BMYNnX9zh?=
 =?us-ascii?Q?/mHOicPEecjSsUvaxSj+Njn43tlu7XpygFNlC22pUyPhWHMmtYTKU6O1PWZq?=
 =?us-ascii?Q?g/4jHgonRA/00BR/9sCNGOkznzQlRqAgEK+kjYOudCf8ZR5+KfuiHxKitYFL?=
 =?us-ascii?Q?1uqhuvB+lUBLXSSODZQDwoHRKgfIfMOXz/vJJ13eau33h8+jyetU223ufNGE?=
 =?us-ascii?Q?BSEFb8Pppaq+G4FSXFU6Nl0ms/etsWQmniG1c7jlk8RuVe5IqpliIYHkRjw5?=
 =?us-ascii?Q?7WcOwo2ty6ePrPTjF6ZCDx+oyLU268b+q7dGyO3zTsCc9+BWMWcJe9EvzN8f?=
 =?us-ascii?Q?YRNX6R7Cgwtnpa0jABWeMbC4w6PZZoj9eHayCNWH1vTPCt/ayxFxBQVBPfY8?=
 =?us-ascii?Q?sGN9pIIvmxOoFTN4oTBpIshIS7ElAkd5FRyDFL3PziNZL070D/v/IJpvSlY8?=
 =?us-ascii?Q?grHv4UccsPKIRsw2qAC/N8FpY45JY+HjFF3IVC5IX0wRI50zxZSKPsmMwhsj?=
 =?us-ascii?Q?olC2c0zuLawJ71gZC5GSPCdVxpRBACI8YBYNQsBZRK+/s1VxPrI3v7mb/5KK?=
 =?us-ascii?Q?v8FW8Qss+Zzw6LAqwk1hRrQ6TTpsgVAyAXbMZ/D+OOmmDpCJ65qumMu1RjSM?=
 =?us-ascii?Q?Fjb1PSVI8cv3DSWABKplUXSDDtG5DFRY0S0yT6mBXv5KxYH0M7Fc90XN+83n?=
 =?us-ascii?Q?HeieDKXeW4JY1W3MJ6HppMyRdSPd1uh4zSoTvy9L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1a6eb6-9afb-4389-f234-08dbd91e0835
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:58:41.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFQYXqZ2BE7e4Vi/yaNT97F6ZyULcJPHz2nebiIdQrieeTI4TL0Xoo2yQ+ueqC8B3qObZNOssgGS9hoe784AovJ3mHNx3RAf2Tn5pGkx76A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I'm looking over the spi-pxa2xx.c driver to get some more performance out o=
f the SPI on an Intel Tiger Lake E processor. I have some questions about t=
he history of the driver and how the HW works which will hopefully help to =
improve the driver.

reset_sccr1()
As far as I can see, this was changed significantly over time. But it's bas=
ically used in the same way.

Looking at 5.10 it was clearing out the interrupt enable bits and setting t=
he rx/tx thresholds to values stored in chip->threshold.
	sccr1_reg =3D pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
	sccr1_reg &=3D ~SSCR1_RFT;
	sccr1_reg |=3D chip->threshold;
	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);


What it does now (6.6 rc7) is clear out the entire register with the except=
ion of the treshold (which is passed as the value parameter to spi_update).=
 Am I missing something or can the Read-Modify-Write operation never save a=
 write here because reading the HW register with a mask of drv_data->int_cr=
1 | drv_data->dma_cr1 and comparing it to a threshold value will always yie=
ld false, right?
u32 mask =3D drv_data->int_cr1 | drv_data->dma_cr1
threshold is either chip->threshold or 0
pxa2xx_spi_update(drv_data, SSCR1, mask, threshold);

with the update function:

static void pxa2xx_spi_update(const struct driver_data *drv_data, u32 reg, =
u32 mask, u32 value)
{
	if ((pxa2xx_spi_read(drv_data, reg) & mask) !=3D value)
		pxa2xx_spi_write(drv_data, reg, value & mask);
}

Am I missing something or could the reset routine be written in a similar f=
ashion as it was in 5.10 but even omitting the read and always writing it. =
As far as I can see there are no status/control bits in that register that =
are modified by hardware so the driver should know the latest configuration=
 and can write it to that while clearing the interrupt enable bits, right? =
The changes to include the special case with no message available can of co=
urse be handled as well.

In general: Can it be quantified for this driver how expensive reads and wr=
ites to registers are? The spi_update routine is written in a way to try to=
 save writes if I interpretate that correctly, is that worth a read every t=
ime? From my understanding and quick tests these RMW operations on the SPI =
control registers seem to be expensive and doing write only can help speedi=
ng up the SPI transfers. One issue I have is that I currently don't have a =
good idea of how many different sets of HW this driver addresses. From the =
datasheets I could find there's a couple intel embedded platforms using thi=
s. But the datasheets I found are rather vague when it comes to determining=
 what clock is being used to access registers etc.=20

I implemented a polling mode in the same way as here: https://lore.kernel.o=
rg/linux-arm-kernel/20220502175457.1977983-9-mkl@pengutronix.de/=20
Results on the Tiger Lake E hardware I have are promising, but the question=
 is how to set limits for a mainline patch for this. Reading the commit mes=
sage of 579d3bb it seems for some platforms it would be a terrible idea to =
have polling method. "On Sodavile the busy flag disappears pretty quick and=
 after that it takes approx ~130ms (sometimes less but not much) until ther=
e are bytes available in the RX FIFO." What would be the best way to handle=
 this? Use an aggressive limit for the timeout and implement it like it's i=
mplemented on the imx driver and fallback to PIO? Blacklisting of specific =
platforms for this feature?

Thanks,
Thomas
