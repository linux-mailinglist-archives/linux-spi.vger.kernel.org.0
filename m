Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548172D6202
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgLJQda (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 11:33:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46929 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390057AbgLJQda (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 11:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607618008; x=1639154008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N/J88fCq84JBRsNQb1y3k/tXFbcNx0HGb6D4cRss22c=;
  b=I+M6uUpMrkuMMNPExa6+Rml6AQjYsPW6P7fA+vqgz6uU++Zl60Q5whqa
   2TORf8u2nc8VDQZyxqSgpLZbRqJuy+T9OFVT63PqBtO+GGIRHPydE84Yi
   AL5um3VFOnQP4rGsjr9IPAhjElv/nzAIZzh7jf4Q5R+LFzAZ8kfWy9+Os
   HvUrPbJXIbs8efdyxsJk9WBI0CWE4cPTDMKepoZXmUN5WnvMRF22SoaVi
   AXCFu+mHKJXKza18+fuk3VWUgFUBPWo33t/aIuxOPhZk+DMAFOVhIk++6
   tH0P+dhcTheWjkd929pBqlOgeMEIpYUNoER0xwItjRqDt6qiEijy/T3hD
   g==;
IronPort-SDR: T7wd123VDyRSQmA8jh8XYJ67cEniohN4+4bWqA/Joi0AU9luXU+TJiSAwBtOFMfMxrIFSZi2Uf
 18VebRulPTdqiRyCbauigXREhLIQ4J8k8vec3R5ovRPPy34uMqlUmmRIuq5mRXlJ5iyEiQG3Km
 QrRl1IA1rEb+/cZhLMjIA+3tA8ePrW1DIrG9cZuweg8XbDq87WwiqsmpliYD5axeTTMbxBdqVK
 7BUm4GdxBlTy+ez/u7PYG+iDd4KUlJk6N7XnTO6yQ+m7vT+MTW9RAodhcXWZIl3iSy8NXdJJNE
 IK0=
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="36958306"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2020 09:32:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 09:32:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Dec 2020 09:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9pURdg5NWUQ4XW6mvyKYM6fwXiEqMxeykBL3Eqs/hGyMHTmjyNXB/NmQXznYfzqZSnzfDva5+KvgQcvZWnLxNzKSIoWYpBu9Qfgk3TsWdzh1LL0egABk/txPm+6gqyeYjkWfJMKLTOq2Ygwm3PEkUpLFD/xHpn1KJAUgZoOueUvf5MS2m4kTxetcy/H9WpEvmb5ekbDGTw9gsVvXUC+zWExmJ1F/7+W8PbxuaclHLvoQHQZXh47b2M+sRre/CsUriFWNeJ1jJzbYGQ2Djoba+sI5iBEau+ioTVSCpl5TQ1/hrah/Grmi6Yg184r8lJwOIgP7HJj/9BcvIVEe98izQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/J88fCq84JBRsNQb1y3k/tXFbcNx0HGb6D4cRss22c=;
 b=UJWZ0nrpNKmD8OtuJF+Dowy5T6vPu7DrILEAIVd1pWg3oaxB8oMVRlpp7xFtUykJYFTjSf7lxUQpWqMRia7gxZcHYpZlMLW19xUH9xijQph9kSkViGjfYxP/gPe1zIf71M3PhxMmIHI4NGzykOaBflgWAo/DeQzPn76SB54VGdLPnFnpHn2i+jsvpwKY4QHPN36lXuxyK/mxePENt7KNxUKTkHzbanFTDHXYHsI8BNX6DFmKx+/Ao3iz5/1f1wY4ssCwPPaRsdzBirmlKk9bIqdHbe1SedQH0peIMTK1Jk6Qovn5qePS2eMv0fe6hUdjsvsd+ULVXW+vrx7EEa772A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/J88fCq84JBRsNQb1y3k/tXFbcNx0HGb6D4cRss22c=;
 b=NNxuqSKKAKxYHjKk/+hzBeVpfrz15RupECHS24PHAWrZ6RnPhWn0oCR+IAK5AR3Ox8j5Qs7d2YtQBTve1WbEmEU7kib7xPSli/XzOecf1w3T1ao8PzfSDNLt4750qiSWm/7YHFNVFwl4u1lxvzePPW7aKGsev9mnfni4hoR+qJA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 16:32:03 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 16:32:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <fancer.lancer@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] spi: Limit the spi device max speed to controller's
 max speed
Thread-Topic: Re: [PATCH] spi: Limit the spi device max speed to controller's
 max speed
Thread-Index: AQHWztKZmHDw6aLncEO1O0nh7I/99A==
Date:   Thu, 10 Dec 2020 16:32:02 +0000
Message-ID: <6e182961-fb4e-d7f6-fe05-abfdd99d2ac5@microchip.com>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
 <20201209201535.32g4kwpzo45jiqr3@mobilestation>
 <20201209202552.GE4790@sirena.org.uk>
 <20201209203042.oqbcijwaxqt5aa7b@mobilestation>
 <48bf85a0-4a98-7e81-0802-c5fac762234f@microchip.com>
 <20201210153351.GB4747@sirena.org.uk>
In-Reply-To: <20201210153351.GB4747@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2ec3635-a98d-4083-336f-08d89d29201b
x-ms-traffictypediagnostic: SA0PR11MB4766:
x-microsoft-antispam-prvs: <SA0PR11MB476688EA23CDE6AD121EE68DF0CB0@SA0PR11MB4766.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DW/3+b3qnSXbjJZfHrXKipmgdZoQSePKyJumxOpjj+v332n7cqzQaYFm5HuKd2zFxib6evPmNv1R7mQd4ptSrwLJZhZcAou1cSSBlYN1M2V0jL4Ar0WQLo/jZLDcBDw+4huuVQzoKdWmBPIPVMrRqm/cTubisDq/XM0lOf36pOHgVCy0SrF86Ms9BsQZzMEO1ihV59AipbqZzA+tAddg9IhkuP7T9J3DSLBJ0S6OXmZFwSCjjOUZXZTY31HGwmavl6DfBCgX5ZnD4RdfcCzRsfd9OOZgrArBtZ7S+nKKYuI6aLgRzBEi0ARc3vEswbWVoWUUu8/6aF8JWucD/K1sI40v+czOtufE/aC/S+M93yBf9Qlm9xLEblc9BKUdFnl0W1l59p8MWpd+Nnk/lXdr5E+AS9vobQspxLcD8+5NWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(91956017)(6916009)(6512007)(186003)(54906003)(71200400001)(2906002)(8676002)(2616005)(8936002)(31696002)(508600001)(36756003)(5660300002)(64756008)(26005)(53546011)(66476007)(83380400001)(6506007)(6486002)(86362001)(31686004)(4326008)(66556008)(66946007)(66446008)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AgHMia6yBLhbYi3/F8bl3DZeOkO5h41STTdFSufAMXkpeRm9Pw3dgG/K2TOjhUjDA3qaP0MBIhsHUQ2wdkIZCy9QnSO/LpT6l+EE8lJs99QGxVHJNut4HU+F2Pys74WCzJoKXB/eaLNY9oqlIvEU5Yoc/Flvjgpf5cx/fwVUyhNFE9+RMlPFScrMmm8afrMc7QBjo6/OLdEu7X86XvyfZ89CBSb06TfADaQtenxBZk1aktxe4uKOGtpC0KyWOX/Gi2/Rlm2LRZ+mSI85lcqjZSq4QpSzor6cdTZCVwIG47KANJVlzsaUgJGnpVyVpLQFQJpXQ0y4ZlrTN5IYTXbJY0mypp4tFPNPZ2y6fCiamnKrPEk7MRz4HrgAZt7w6/wfGFIGwWplYHikL9eO1lC6O2MevWBWV7Oh1a10CRdUgk+VbWUFG2k5uB1k5lX4bdAjPfXBUDJuRa2G3XfBGBlJCG/Su1SaYCmUKuhvLxkQohWeoxsO0v0cycPqt1KvnXvLcrz3tjf7UkPaTh30deDnPuUnmLLtfJkG6YYS3JYCAwptVZqMk2hb5MrVz1hYjSQxKtN/5sEH++usArFqQbz0wfLMJSdRhItMRFVwUDaODLCA78ignjlPvSZQci1O7jMNiIlmWoY+AcLfCuRAVu6g2CJvRSMISECZ3or5mWuMwFydvOUxkEfke2Q+e6gC0sCFnj9tYlcr/bv4NA3uMQfDK0mTylC3fOGlHNqJAZ91dOY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <44097F3684B703499569BD3E113E0527@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ec3635-a98d-4083-336f-08d89d29201b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 16:32:02.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJBjKdyLU/8MeqwrFJbKTz+h9AJ3Xt1ghjnd4H9DazCDxdcb7El1gLro1HH537MDoZ9p6oVlpXNE+P9VCS0A6QWbxmQ21tv0GSqqHRahWBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/10/20 5:33 PM, Mark Brown wrote:
> On Thu, Dec 10, 2020 at 08:58:18AM +0000, Tudor.Ambarus@microchip.com wro=
te:
>> On 12/9/20 10:30 PM, Serge Semin wrote:
>=20
>>>>>> Right, in general we aim to do this sort of fixup on the transfers
>>>>>> and messages rather than the devices, I guess we might be missing
>>>>>> validation in some of the flash acceleration paths or was this an is=
sue
>>>>>> seen through inspection?
>=20
>> We miss validation for the SPI controllers that provide the
>> spi_controller_mem_ops with its exec_op() method. In this case the SPI
>> core does not check if the max_speed_hz of spi_device overrides the
>> max_speed_hz of controller.
>=20
>> This was seen through inspection. There are octal SPI NOR flashes that
>> can run at 400 MHZ, and I've also seen SPI controllers that are limited
>> to 200 MHZ (microchip's sama7g5 octal SPI for example, which is not yet
>> in mainline).
>=20
> Right, that's the hole :/
>=20
>>>> Ideally the driver wouldn't have to check though (no harm in doing so =
of
>>>> course).
>=20
>> Right. I thought of doing this in the SPI core, rather than doing in (ea=
ch)
>> controller driver.
>=20
> Yes, we should just make sure things are OK in the core as much as we
> can so there's less work for driver authors.
>=20
>>> If so then we'd need to have a dedicated speed-related field in the
>>> spi_mem_op structure, which would be accordingly initialized by the
>>> SPI-mem core.
>=20
>> We do need a max_speed_hz in the SPIMEM, but probably for other purposes=
:
>> NOR flashes, for example, can discover the maximum supported frequency
>> at run-time, when parsing the jesd216 SFDP tables. One may consider that
>> the run-time discovered max_speed_hz should have a higher precedence tha=
n
>> what we fill with the spi-max-frequency dt property, because the
>> manufacturers/jesd216 standard know/s better. Of course, if the
>> manufacturers put a wrong max_speed_hz in the sfdp table, that can be
>> updated at runtime with a fixup() hook, on a case by case basis. Other
>> thing to consider here, is the max_speed_hz supported by the PCB. For
>> example if the SPI flash supports 400 MHZ, the controller 200 MHZ, but
>> the PCB only 180 MHZ, then we'll have to synchronize all three. But this
>> seems like a discussion for other patch.
>=20
> The potential for board issues suggests that we should be taking the
> minimum of what the board DT and runtime discovery say - if the board
> limits things more than the parts we should assume that there's a system
> integration limitation there.
>=20
>> Let me know if you think that this patch is ok for now. I can update the
>> commit message if needed.
>=20
> It does work for now but it'd be nicer if we were doing this through
> recording the decision on the transfer.
>=20

Ok, we can drop the patch, as nobody complained about this until now. I can
work on a better approach. Are you saying that we should calibrate/adjust t=
he
maximum supported frequency on each operation/command? Most of the commands
can work at the same frequency. I know an exception: on SPI NOR flashes, th=
e
jesd216 standard specifies that the READ SFDP command should be run at 50MH=
z,
even though the rest of the commands/opcodes can run at a higher frequency.
It is common that flashes can run this command at 50+ MHz, and nobody bothe=
red
about adjusting the frequency at run-time until now. That being said, maybe=
 we
can calibrate/adjust a generic max frequency for most of the commands and
treat the exceptions on a per operation basis.

Cheers,
ta
