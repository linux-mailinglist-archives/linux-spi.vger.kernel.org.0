Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAC21F0C3
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGNMQV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 08:16:21 -0400
Received: from mail.loongson.cn ([114.242.206.163]:39378 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728541AbgGNMQU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 08:16:20 -0400
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Tue, 14 Jul 2020
 20:16:13 +0800 (GMT+08:00)
X-Originating-IP: [113.200.148.30]
Date:   Tue, 14 Jul 2020 20:16:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Qing Zhang" <zhangqing@loongson.cn>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>
Subject: Re: Re: [PATCH] spi: Use clk_prepare_enable and
 clk_disable_unprepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2020 www.mailtech.cn .loongson.cn
In-Reply-To: <20200714094406.GA4900@sirena.org.uk>
References: <1594717754-25428-1-git-send-email-zhangqing@loongson.cn>
 <20200714094406.GA4900@sirena.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5614bc2e.1259.1734d41040f.Coremail.zhangqing@loongson.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAf9Dxvx8Oog1fSm8EAA--.1037W
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/1tbiAQARBV3QvMCRdgAGsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CgoKJmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KJmd0OyBGcm9tOiAiTWFyayBCcm93
biIgPGJyb29uaWVAa2VybmVsLm9yZz4KJmd0OyBTZW50IFRpbWU6IDIwMjAtMDctMTQgMTc6NDQ6
MDYgKFR1ZXNkYXkpCiZndDsgVG86ICJRaW5nIFpoYW5nIiA8emhhbmdxaW5nQGxvb25nc29uLmNu
PgomZ3Q7IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnLCAiWHVlZmVuZyBMaSIgPGxpeHVlZmVuZ0Bsb29uZ3Nvbi5jbj4sICJUaWV6aHUg
WWFuZyIgPHlhbmd0aWV6aHVAbG9vbmdzb24uY24+CiZndDsgU3ViamVjdDogUmU6IFtQQVRDSF0g
c3BpOiBVc2UgY2xrX3ByZXBhcmVfZW5hYmxlIGFuZCBjbGtfZGlzYWJsZV91bnByZXBhcmUKJmd0
OyAKJmd0OyBPbiBUdWUsIEp1bCAxNCwgMjAyMCBhdCAwNTowOToxNFBNICswODAwLCBRaW5nIFpo
YW5nIHdyb3RlOgomZ3Q7ICZndDsgQ29udmVydCBjbGtfZW5hYmxlL2Nsa19kaXNhYmxlIHRvIGNs
a19wcmVwYXJlX2VuYWJsZS9jbGtfZGlzYWJsZV91bnByZXBhcmUKJmd0OyAmZ3Q7IGNhbGxzIGFz
IHJlcXVpcmVkIGJ5IGNvbW1vbiBjbG9jayBmcmFtZXdvcmsuCiZndDsgJmd0OyAKJmd0OyAmZ3Q7
IFNpZ25lZC1vZmYtYnk6IFFpbmcgWmhhbmcgPHpoYW5ncWluZ0Bsb29uZ3Nvbi5jbj4KJmd0OyAm
Z3Q7IC0tLQomZ3Q7ICZndDsgIGRyaXZlcnMvc3BpL3NwaS1jb2xkZmlyZS1xc3BpLmMgfCA0ICsr
LS0KJmd0OyAKJmd0OyBBcmUgeW91IHN1cmUgdGhhdCBDb2xkRmlyZSB1c2VzIHRoZSBjb21tb24g
Y2xvY2sgZnJhbWV3b3JrPwomZ3Q7IAomZ3Q7ICZndDsgIGRyaXZlcnMvc3BpL3NwaS1vbWFwLXV3
aXJlLmMgICAgfCA0ICsrLS0KJmd0OyAKJmd0OyBJdCBtYWtlcyBsaWZlIGVhc2llciBpZiB5b3Ug
c2VuZCBwZXItZHJpdmVyIHBhdGNoZXMsIHRoYXQgbWFrZXMgaXQKJmd0OyBlYXNpZXIgZm9yIGRy
aXZlciBtYWludGFpbmVycyB0byByZXZpZXcgdGhpbmdzIGFuZCBtZWFucyB0aGF0IGlzc3Vlcwom
Z3Q7IHdpdGggYSBjaGFuZ2UgaW4gb25lIGRyaXZlciB3b24ndCBob2xkIHVwIGFub3RoZXIuCgoK
SGkgTWFyaywKCgpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbi4KCkkgd2lsbCBzcGxpdCB0
aGlzIHBhdGNoIGludG8gdHdvIHBhdGNoZXMgYW5kIHRoZW4gc2VuZCB2Mi4gCjwvemhhbmdxaW5n
QGxvb25nc29uLmNuPjwveWFuZ3RpZXpodUBsb29uZ3Nvbi5jbj48L2xpeHVlZmVuZ0Bsb29uZ3Nv
bi5jbj48L3poYW5ncWluZ0Bsb29uZ3Nvbi5jbj48L2Jyb29uaWVAa2VybmVsLm9yZz4=
