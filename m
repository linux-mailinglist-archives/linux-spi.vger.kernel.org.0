Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1DF20350B
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgFVKqi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 06:46:38 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:64510 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgFVKqi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jun 2020 06:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592822797; x=1624358797;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=KHvJLP0itNpakCb4tg71Js5YXmKvGUBsqp96jfT9yXw=;
  b=sJrF4WUSM6wBYbfjj7vWTa+pVUOf12sweLJs3sLi7/AsDN4I4DfQOKKp
   3FTIHpzOCWmpLChR3hM0IK3hspO7KTr31mZ4+Z9WAHnvCJ4aStwCTZZD1
   x90KlSHHdQIGGDe9K25PpGUN4U/qay/C0FkdGFlEZ/WPa1RsoaxVj+j7m
   OovA+PQAIsEpMHwvSn0b1O08od/wya2CyvXlYb8XS7IAuunIYvUlMQBbO
   leXkBLTNfp/iu7OnUkmXslcClcZhmh8ZHa2eew9NQ3Zx+t6RPiZPFQq7A
   75eWHeEKK2iR+PcfKXdhF9AvOjRWEmWaCEuUitZEzvwKn9lFyOqfaTt4p
   A==;
IronPort-SDR: jIDnA4F4tHU6zBj7u39UFZocR2sz485FomgdldxzhJc4VCJUfL7MIcbRuLFTJp2SBt2pRul5sR
 NIeN5Cdwsxez19lhBD8/B+m6pclB0eJ+dQ/z7tvXIZuRs62yPkutgDPygnZP6HszIP55Mi3Ek8
 Xw/t0xKt3INxH7jxs77pnHINpQ+LVoB/NsVJXBXvwfxHwvivMlBBDRmYIbW8nYQ+Y9Vh/zeJJH
 +0QJHSu+m6WINc3x9cGKc+zeI/bI23cCYj4eaL99NqE0HwVT/SFi3ZPKnMWovuISDQTATMxoS8
 hBQ=
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="16577354"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2020 03:46:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 03:46:36 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 22 Jun 2020 03:46:34 -0700
References: <20200619113121.9984-1-lars.povlsen@microchip.com> <20200619113121.9984-4-lars.povlsen@microchip.com> <20200619121107.GE5396@sirena.org.uk>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/6] spi: dw: Add Microchip Sparx5 support
In-Reply-To: <20200619121107.GE5396@sirena.org.uk>
Date:   Mon, 22 Jun 2020 12:46:33 +0200
Message-ID: <87imfjxtrq.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Mark Brown writes:

On Fri, Jun 19, 2020 at 01:31:18PM +0200, Lars Povlsen wrote:

>> +/*
>> + * The Designware SPI controller (referred to as master in the
>> + * documentation) automatically deasserts chip select when the tx fifo
>> + * is empty. The chip selects then needs to be driven by a CS override
>> + * register. enable is an active low signal.
>> + */
>> +static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool nEnable)
>
>The value that is passed in here is the value that should be driven on
>the output pin, the driver should not be interpreting the value in any
>way here.  Documenting it as nEnable adds a layer of confusion, and it
>may not be an active high signal depending on the system.

Ok, I will make the CS function more like the others.

>
>> +	if (!nEnable) {
>> +		/* Ensure CS toggles, so start off all disabled */
>> +		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~0);
>> +		/* CS override drive enable */
>> +		regmap_write(dwsmscc->syscon, SPARX5_FORCE_ENA, 1);
>
>This should just be setting the value to whatever the core asked for it
>to be set to, the driver adding extra toggles is likely to disrupt
>things.

I will have a look at this again. But it was added for a reason. The
issue is that we have two different busses in front of the controller,
so we might need more settle time when switching interface.

Thank you for you comments,

Cheers

-- 
Lars Povlsen,
Microchip
