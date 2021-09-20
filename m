Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EB641172D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhITOg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 20 Sep 2021 10:36:56 -0400
Received: from mail.bytesnap.co.uk ([94.198.185.106]:45507 "EHLO
        mail.bytesnap.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhITOg4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 10:36:56 -0400
Received: from exch2016.ByteSnap.local (10.0.28.253) by
 exch2016.ByteSnap.local (10.0.28.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 15:35:28 +0100
Received: from exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0]) by
 exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0%8]) with mapi id
 15.01.2308.014; Mon, 20 Sep 2021 15:35:28 +0100
From:   Ville Baillie <VilleB@bytesnap.co.uk>
To:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.sneddon@microchip.com" <dan.sneddon@microchip.com>
Subject: RE: [PATCH v3] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH v3] spi: atmel: Fix PDC transfer setup bug
Thread-Index: AdeuLBk8YnhgPjL7Rzy2vzFY84KgkAAAHhXg
Date:   Mon, 20 Sep 2021 14:35:28 +0000
Message-ID: <0f470fb0bb394d279ff0b734e5c6b871@bytesnap.co.uk>
References: <60f0c65bbd52479cb83683b8475af435@bytesnap.co.uk>
In-Reply-To: <60f0c65bbd52479cb83683b8475af435@bytesnap.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.27.202]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

My apologies, it appears my email client is mangling the patch.

I will resend if I can get 'git send-email' working.

Thanks
Ville
