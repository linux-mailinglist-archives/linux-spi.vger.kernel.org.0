Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922252053E2
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgFWNxa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 09:53:30 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:65017 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbgFWNx2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Jun 2020 09:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592920408; x=1624456408;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=Wh8tlTmkeLmBURIATHl2HVTtETUBHTovyprw1YhBJSM=;
  b=SMdXrCDFMmZVp3bb5Z5x1QczWxPpCryOKnOjKQ8sYF7MsyMG7KbwChWv
   fGwf91boFgwKYuCSdQ6gkCMtHl64dyE4fX8orILhPyJcQoWNEPOHAlWUd
   UN6Aq7y6bHK4WHqFDP6OxvkUaxFle4ozNain3uQDP0YKFMinJSnZO73z6
   qz6t5z+ouvx3sYh9le45gPu36BlDJxUrpNXS528YO7mi6Hp/GyTc5lwY1
   F8lJ8V/NBlb3l6QZoyINtU9sYNR19j9bdLbXX1M3ldxnolflFRzLZGBOK
   rYd1rtTLtYA5qccP2P4QkFnE1SPH722LgaFipBZr8xp64rBkOfAIeszI/
   Q==;
IronPort-SDR: Hq1PluohMkhb19j9nTJJm20AtFbnzLD8gz48m6b5MdsUHRS/VsQMz2/eU3gp6WRbjRTlmIfWG8
 l6EztbvEEyQl/q8Ey00w82H6iIaiWVNRlYxzfBM9pUqWzG10mmNVZ9Zmgoxw1laDhW/EVCY4sG
 xon+qyF5ghrjG4FBnQacQicEChjGOxXMTVEgCzjmqgSvvq/wj8sC46ntVkOi1E/U7E3kKmTp7V
 vD1D7Gu8nKx9rsP8pX6Bq+117suOEQUaHH99ahxigiBndUKVkvrR2Knn+tjGzYvnr5gODwDXH7
 b5w=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="81216978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 06:53:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 06:53:14 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 23 Jun 2020 06:53:12 -0700
References: <20200619113121.9984-1-lars.povlsen@microchip.com> <20200619113121.9984-4-lars.povlsen@microchip.com> <20200619121107.GE5396@sirena.org.uk> <87imfjxtrq.fsf@soft-dev15.microsemi.net> <20200622121706.GF4560@sirena.org.uk>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/6] spi: dw: Add Microchip Sparx5 support
In-Reply-To: <20200622121706.GF4560@sirena.org.uk>
Date:   Tue, 23 Jun 2020 15:53:22 +0200
Message-ID: <878sgddh2l.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Mark Brown writes:

On Mon, Jun 22, 2020 at 12:46:33PM +0200, Lars Povlsen wrote:
>> On Fri, Jun 19, 2020 at 01:31:18PM +0200, Lars Povlsen wrote:
>
>> >> +	if (!nEnable) {
>> >> +		/* Ensure CS toggles, so start off all disabled */
>> >> +		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~0);
>> >> +		/* CS override drive enable */
>> >> +		regmap_write(dwsmscc->syscon, SPARX5_FORCE_ENA, 1);
>
>> >This should just be setting the value to whatever the core asked for it
>> >to be set to, the driver adding extra toggles is likely to disrupt
>> >things.
>
>> I will have a look at this again. But it was added for a reason. The
>> issue is that we have two different busses in front of the controller,
>> so we might need more settle time when switching interface.
>
>If there's a mux that needs to be handled specially that mux should be
>described in DT on the relevant boards, there shouldn't just be
>something hard coded in the controller driver.

I have been able to change this into a straight setting - no
toggling. Just needed a settle delay.

I looked at the spi-mux driver, but that is more for muxing the CS's, as
I understand - not the actual bus segment. I could use it, but it would
require encoding the bus segment into the CS (double the normal
range). Also, selecting the bus interface is tightly coupled to the
controller - its not an externally constructed board mux.

I feel the current implementation is more to the point, and easily
understandable. It just adds the "microchip,spi-interface2" DT property.

It might be that a better way exists using the spi-mux framework, and if
you have some ideas for that I'd be all ears.

>
>BTW please do not CC subsystem patches to soc@kernel.org unless there's
>a specific reason to do so - there's no need for it, these patches won't
>get merged via there unless something is going wrong.  Generally the
>subsystem maintainers take patches for a given subsystem.

Ok, duly noted.

Thank you for the comments.

---Lars


-- 
Lars Povlsen,
Microchip
