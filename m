Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E530FFDA1
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2019 05:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfKRE6M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 17 Nov 2019 23:58:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:50761 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726347AbfKRE6L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 17 Nov 2019 23:58:11 -0500
X-UUID: 6c1f2ecea9d246268c902867d4192d9e-20191118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cFCudjariDZ9dPYX7zDkbr0ezd58dL0l8GffmHcsUbk=;
        b=Gy1YUg4yZ/+Bnu6nAXh7hrtcRoFHKfEEuWpZGgg6bFwBw0WU5fIqiLH5tcjnXmQCs11ypaxVYZqpRMzMm1We1IdbpVc0MCuFUpR1PK6aL2Bq/DhQ310rdAHFr2B1v0DqXpD92rK2x7Wt+c2ijxK2bnuNT+5+ODcoA3UYDYY7oXo=;
X-UUID: 6c1f2ecea9d246268c902867d4192d9e-20191118
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 390284999; Mon, 18 Nov 2019 12:57:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Nov 2019 12:57:06 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 18 Nov 2019 12:57:43 +0800
From:   Luhua Xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Luhua Xu <luhua.xu@mediatek.com>
Subject: [PATCH 1/2] spi: mediatek: add SPI_CS_HIGH support
Date:   Mon, 18 Nov 2019 12:57:16 +0800
Message-ID: <1574053037-26721-2-git-send-email-luhua.xu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1574053037-26721-1-git-send-email-luhua.xu@mediatek.com>
References: <1574053037-26721-1-git-send-email-luhua.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DE1900F93D357E82F39EBE3D6EC1C540731BF3D8A546E01EB95384160FCD19D02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Q2hhbmdlIHRvIHVzZSBTUElfQ1NfSElHSCB0byBzdXBwb3J0IHNwaSBDUyBwb2xhcml0eSBzZXR0
aW5nDQpmb3IgY2hpcHMgc3VwcG9ydCBlbmhhbmNlX3RpbWluZy4NCg0KU2lnbmVkLW9mZi1ieTog
THVodWEgWHUgPGx1aHVhLnh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc3BpL3NwaS1t
dDY1eHguYyAgICAgICAgICAgICAgICAgfCAxMiArKysrKysrKysrLS0NCiBpbmNsdWRlL2xpbnV4
L3BsYXRmb3JtX2RhdGEvc3BpLW10NjV4eC5oIHwgIDEgLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Bp
L3NwaS1tdDY1eHguYyBiL2RyaXZlcnMvc3BpL3NwaS1tdDY1eHguYw0KaW5kZXggNjg4OGE0ZC4u
ZjU5OWNjZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1tdDY1eHguYw0KKysrIGIvZHJp
dmVycy9zcGkvc3BpLW10NjV4eC5jDQpAQCAtMTM5LDcgKzEzOSw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX3NwaV9jb21wYXRpYmxlIG10ODE4M19jb21wYXQgPSB7DQogICogc3VwcGxpZXMg
aXQuDQogICovDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY2hpcF9jb25maWcgbXRrX2RlZmF1
bHRfY2hpcF9pbmZvID0gew0KLQkuY3NfcG9sID0gMCwNCiAJLnNhbXBsZV9zZWwgPSAwLA0KIH07
DQogDQpAQCAtMjMwLDEwICsyMjksMTIgQEAgc3RhdGljIGludCBtdGtfc3BpX3ByZXBhcmVfbWVz
c2FnZShzdHJ1Y3Qgc3BpX21hc3RlciAqbWFzdGVyLA0KICNlbmRpZg0KIA0KIAlpZiAobWRhdGEt
PmRldl9jb21wLT5lbmhhbmNlX3RpbWluZykgew0KLQkJaWYgKGNoaXBfY29uZmlnLT5jc19wb2wp
DQorCQkvKiBzZXQgQ1MgcG9sYXJpdHkgKi8NCisJCWlmIChzcGktPm1vZGUgJiBTUElfQ1NfSElH
SCkNCiAJCQlyZWdfdmFsIHw9IFNQSV9DTURfQ1NfUE9MOw0KIAkJZWxzZQ0KIAkJCXJlZ192YWwg
Jj0gflNQSV9DTURfQ1NfUE9MOw0KKw0KIAkJaWYgKGNoaXBfY29uZmlnLT5zYW1wbGVfc2VsKQ0K
IAkJCXJlZ192YWwgfD0gU1BJX0NNRF9TQU1QTEVfU0VMOw0KIAkJZWxzZQ0KQEAgLTI2NCw2ICsy
NjUsOSBAQCBzdGF0aWMgdm9pZCBtdGtfc3BpX3NldF9jcyhzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
LCBib29sIGVuYWJsZSkNCiAJdTMyIHJlZ192YWw7DQogCXN0cnVjdCBtdGtfc3BpICptZGF0YSA9
IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5tYXN0ZXIpOw0KIA0KKwlpZiAoc3BpLT5tb2Rl
ICYgU1BJX0NTX0hJR0gpDQorCQllbmFibGUgPSAhZW5hYmxlOw0KKw0KIAlyZWdfdmFsID0gcmVh
ZGwobWRhdGEtPmJhc2UgKyBTUElfQ01EX1JFRyk7DQogCWlmICghZW5hYmxlKSB7DQogCQlyZWdf
dmFsIHw9IFNQSV9DTURfUEFVU0VfRU47DQpAQCAtNjQ3LDYgKzY1MSwxMCBAQCBzdGF0aWMgaW50
IG10a19zcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJbWRhdGEg
PSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rlcik7DQogCW1kYXRhLT5kZXZfY29tcCA9IG9m
X2lkLT5kYXRhOw0KKw0KKwlpZiAobWRhdGEtPmRldl9jb21wLT5lbmhhbmNlX3RpbWluZykNCisJ
CW1hc3Rlci0+bW9kZV9iaXRzIHw9IFNQSV9DU19ISUdIOw0KKw0KIAlpZiAobWRhdGEtPmRldl9j
b21wLT5tdXN0X3R4KQ0KIAkJbWFzdGVyLT5mbGFncyA9IFNQSV9NQVNURVJfTVVTVF9UWDsNCiAN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvc3BpLW10NjV4eC5oIGIv
aW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3NwaS1tdDY1eHguaA0KaW5kZXggZjBlNmQ2NC4u
NjVmZDVmZmQyIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3NwaS1t
dDY1eHguaA0KKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3NwaS1tdDY1eHguaA0K
QEAgLTExLDcgKzExLDYgQEANCiANCiAvKiBCb2FyZCBzcGVjaWZpYyBwbGF0Zm9ybV9kYXRhICov
DQogc3RydWN0IG10a19jaGlwX2NvbmZpZyB7DQotCXUzMiBjc19wb2w7DQogCXUzMiBzYW1wbGVf
c2VsOw0KIH07DQogI2VuZGlmDQotLSANCjIuNi40DQo=

