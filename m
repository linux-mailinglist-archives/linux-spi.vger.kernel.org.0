Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0664B1D00
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 04:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiBKDlk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Feb 2022 22:41:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiBKDlk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Feb 2022 22:41:40 -0500
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF3E72624;
        Thu, 10 Feb 2022 19:41:37 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(29722:1:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Fri, 11 Feb 2022 11:32:02 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 11 Feb 2022 11:32:02 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 11 Feb 2022 11:32:02 +0800
From:   =?big5?B?TGggS3VvILOipE+7qA==?= <lh.Kuo@sunplus.com>
To:     Mark Brown <broonie@kernel.org>, Li-hao Kuo <lhjeff911@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>,
        "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH] spi: Fix warning for Clang build
Thread-Topic: [PATCH] spi: Fix warning for Clang build
Thread-Index: AQHYHichnrMLSeAM6EW6YKfSFQS5w6yMHQcAgAGTjCA=
Date:   Fri, 11 Feb 2022 03:32:01 +0000
Message-ID: <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
 <YgT0LMcDpCEYHFYg@sirena.org.uk>
In-Reply-To: <YgT0LMcDpCEYHFYg@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiANCj4gVGhlIHJldHVybiBoZXJlIG1lYW5zIHRoYXQgdGhlIGluaXRpYWxpemF0aW9uIGlzIG5v
dyByZWR1bmRhbnQgYW5kIHdpbGwgc3RvcCB0aGUgY29tcGlsZXIgc3BvdHRpbmcgYW55DQo+IGZ1
dHVyZSBzaW1pbGFyIGlzc3VlcyB3aGljaCBpc24ndCBpZGVhbC4NCg0KSSBnb3QgaXQsIHNvIGRv
IEkgbmVlZCB0byBzdWJtaXQgYSBuZXcgcGF0Y2g/DQoNCg0K
