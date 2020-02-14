Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA87B15D219
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 07:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgBNG1J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 01:27:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:1421 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgBNG1J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 14 Feb 2020 01:27:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 22:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="313972320"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2020 22:27:07 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Feb 2020 22:27:07 -0800
Received: from bgsmsx103.gar.corp.intel.com (10.223.4.130) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Feb 2020 22:27:06 -0800
Received: from bgsmsx101.gar.corp.intel.com ([169.254.1.159]) by
 BGSMSX103.gar.corp.intel.com ([169.254.4.133]) with mapi id 14.03.0439.000;
 Fri, 14 Feb 2020 11:56:43 +0530
From:   "Srivastava, Shobhit" <shobhit.srivastava@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Mark Brown" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "evgreen@google.com" <evgreen@google.com>,
        "Muthukrishnan, Porselvan" <porselvan.muthukrishnan@intel.com>
Subject: RE: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Thread-Topic: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Thread-Index: AdXijjRJ6+7qPvvhRvGfTavxCinpyv//qqQA//7IthA=
Date:   Fri, 14 Feb 2020 06:26:42 +0000
Message-ID: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C38D7@BGSMSX101.gar.corp.intel.com>
References: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
 <20200213171836.GD10400@smile.fi.intel.com>
In-Reply-To: <20200213171836.GD10400@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWRhMGY2YjItYmEwYi00NTliLWEzNzMtMTUzNTYyMjdmYTI1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaFpJSHZqWlhIVHkzVW93MVwvYVNWWUZwWEhDNVlnRFhyMk5HUTV6cUd4QkE1WHlIeHc5bjRRbSt0QUZZd2J4ODgifQ==
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiANCj4gT24gVGh1LCBGZWIgMTMsIDIwMjAgYXQgMDQ6NTc6MjRQTSArMDAwMCwgU3JpdmFzdGF2
YSwgU2hvYmhpdCB3cm90ZToNCj4gPiA+IE9uIDIvMTIvMjAgMTI6MzQgQU0sIFJhamF0IEphaW4g
d3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiBJIHdvbmRlciBpcyBpdCBlbm91Z2ggdG8gaGF2
ZSB0aGlzIHF1aWNrIHRvZ2dsaW5nIG9ubHkgb3IgaXMgdGltZSBvcg0KPiA+ID4gYWN0dWFsbHkg
bnVtYmVyIG9mIGNsb2NrIGN5Y2xlcyBkZXBlbmRlbnQ/IE5vdyB0aGVyZSBpcyBubyBkZWxheQ0K
PiA+ID4gYmV0d2VlbiBidXQgSSdtIHRoaW5raW5nIGlmIGl0IG5lZWRzIGNlcnRhaW4gbnVtYmVy
IGN5Y2xlcyBkb2VzIHRoaXMNCj4gPiA+IHN0aWxsIHdvcmsgd2hlbiB1c2luZyBsb3cgc3NwX2Ns
ayByYXRlcyBzaW1pbGFyIHRoYW4gaW4gY29tbWl0DQo+IGQwMjgzZWIyZGJjMSAoInNwaToNCj4g
PiA+IHB4YTJ4eDogQWRkIG91dHB1dCBjb250cm9sIGZvciBtdWx0aXBsZSBJbnRlbCBMUFNTIGNo
aXAgc2VsZWN0cyIpLg0KPiA+ID4NCj4gPiA+IEknbSB0aGlua2luZyBjYW4gdGhpcyBiZSBkb25l
IG9ubHkgb25jZSBhZnRlciByZXN1bWUgYW5kIG1heSBvdGhlcg0KPiA+ID4gTFBTUyBibG9ja3Mg
bmVlZCB0aGUgc2FtZT8gSS5lLiBzaG91bGQgdGhpcyBiZSBkb25lIGluIGRyaXZlcnMvbWZkL2lu
dGVsLQ0KPiBscHNzLmM/DQo+IA0KPiA+IFRoaXMgYmVoYXZpb3IgaXMgc2VlbiBhZnRlciBTMGl4
IHJlc3VtZSwgYnV0IGl0IGlzIG5vdCBzZWVuIGFmdGVyIFMzIHJlc3VtZS4NCj4gDQo+IEkgYWxy
ZWFkeSBjb21tZW50ZWQgaW4gdGhlIG90aGVyIHRocmVhZCBhYm91dCB0aGlzLg0KPiANCj4gSGF2
ZSB5b3UgY2hlY2tlZCB3aGF0J3MgZ29pbmcgb24gaW4gaW50ZWxfbHBzc19zdXNwZW5kKCkgYW5k
DQo+IGludGVsX2xwc3NfcmVzdW1lKCkgZm9yIHlvdXIgY2FzZT8NClllcywgSSBjaGVja2VkIHRo
b3NlIGZ1bmN0aW9ucyBhbmQgdGhleSBsb29rIGZpbmUuDQpJIGV2ZW4gZHVtcGVkIGFsbCB0aGUg
cmVsZXZhbnQgcmVnaXN0ZXJzIGZvciBib3RoIFMzIHJlc3VtZSAmIFMwaXggcmVzdW1lIGNhc2Uu
DQpBbGwgcmVnaXN0ZXJzIHdlcmUgc2FtZSBleGNlcHQgdGhlIFNTQ1IwLg0KDQo+IElzIGludGVs
X2xwc3NfcHJlcGFyZSgpIGNhbGxlZCBkdXJpbmcgUzBpeCBleGl0Pw0KWWVzLCBpdCBpcyBjYWxs
ZWQgZHVyaW5nIFMwaXggZW50cnksIGJlZm9yZSB0aGUgc3VzcGVuZCBjYWxsYmFjay4NCg0KPiA+
IEkgYW0gdGhpbmtpbmcgdGhhdCBpdCBoYXBwZW5zIGJlY2F1c2Ugd2UgYXJlIG5vdCBlbmFibGlu
ZyB0aGUgU1NQIGFmdGVyDQo+IHJlc3VtZS4NCj4gPiBJdCBpcyBkZWZlcnJlZCB1bnRpbCB3ZSBu
ZWVkIHRvIHNlbmQgZGF0YS4gQnkgZW5hYmxpbmcgdGhlIFNTUCBpbiByZXN1bWUsIEkNCj4gZG9u
4oCZdCBzZWUgdGhlIGlzc3VlLg0KPiA+IEZvciBTMywgSSB0aGluayBCSU9TIHJlLWVuYWJsZXMg
dGhlIFNTUCBpbiByZXN1bWUgZmxvdy4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0K
PiBBbmR5IFNoZXZjaGVua28NCj4gDQoNCg==
