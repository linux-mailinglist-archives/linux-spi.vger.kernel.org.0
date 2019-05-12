Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346021AE60
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 01:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfELXNk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 May 2019 19:13:40 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfELXNk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 19:13:40 -0400
Received: from maxwell ([61.41.60.66]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MY6P5-1hBzBD0RTB-00YPrk; Mon, 13
 May 2019 01:13:35 +0200
References: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com> <1557144380-19935-2-git-send-email-jh@henneberg-systemdesign.com> <20190508071812.GS14916@sirena.org.uk> <87sgto16kr.fsf@henneberg-systemdesign.com> <20190512082645.GK21483@sirena.org.uk>
From:   Jochen Henneberg <jh@henneberg-systemdesign.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Added driver for CP2130 USB-to-SPI bridge
In-reply-to: <20190512082645.GK21483@sirena.org.uk>
Date:   Mon, 13 May 2019 01:13:30 +0200
Message-ID: <87pnone06d.fsf@henneberg-systemdesign.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:GUJKXcczIC+oepLPe5VwuOerD3FL/b9Wf3O9KiTuM4Mdv7DuBW2
 mjf9PeNb6Ind3P8cCqmWsbLHhBC4Ez8Ti1Y2jg7FVW7aRIEuolDdJbLN2RWvhw+sXiVZjFJ
 tL6OlQLhXJSISZV1jcPbauVeQ9ZdkVVxyS0aB/rRTvwx9gE3fQ+cs173YM0oDPjKpqw8PKZ
 l9YKTsADhzXhFvRYWhvFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KQDXrZt+0eM=:hZsZQ3MES7LsUI30guuUc7
 CJbV7d2gNiwrxgv5quh30IGTez1YJqLc+d1UGXP8gf1daUm+Bra2bEkC3OrjY55RCzpvse2T9
 pTBOJa5BQRUMBmlLA8AGKyb/U6YWS5i1/jvf4jZUZN+graunhmFFwxb5XIBK+A/MMh/xoXP/2
 htVFxmmhdTmVT+RLYgyTRvNvMnS+6gPLwYaZRutS4T7W7wV7yyhp4K6eMkmuc3ssG8dGfJ6IC
 CsMuhcP4VHhoonw0x5BQr9VgHu3cduO2xR2+KRqMBIqkjTTvgc6U/stgu333YIvR3sfK+9JH3
 ApIhVb8ASnanR00pr09y+iEPdMf3Yn6oeJr1cxJtdCJt8yzED6PtiLToK+uKvSpBNCXXibtFY
 q0BWVSTu0C40QNB7XZamjjd7oFSAW9keQ3SwSObpsXUyHaRyTGBS0XX6hek2c+2pJ46tBymfx
 7VuTMdITOikDL9+DLMFyJQVktWPhtzUtCjHCHgRTmH0NsbROP0YoBNwuOheRR0ebpmd16Ncg6
 UkCsoBUHhKnXZsu5FJfg2d4MoTvjenDreWJXG/PYrycPXzjnu44smxIMODV9SrBZO2vzvAa2m
 iOubm3Fkng4fzPYhvlXIGSCZEmOnZlIK/KWL1+hxhCuoQW2jUoxieaLIH6MxCh6sCyaNot93i
 d+EnRh/doOqkVwsre0gDsGpqmZd+dRnOYvEaYfqMyLevfUvDTIBg97EBn4e7kJjnkzHk8S9ws
 k6WhaB/8MxHjgNzS+dRQTitG2kY1GHsCam5x6iDAsB2cWBEEfzarCu/uYZlKlxAvRHYkZx+9n
 pMYwZHx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Thu, May 09, 2019 at 08:32:20AM +0200, Jochen Henneberg wrote:
>> Mark Brown <broonie@kernel.org> writes:
>> > On Mon, May 06, 2019 at 02:06:20PM +0200, Jochen Henneberg wrote:
>
>> >> +	mutex_lock(&chip->chn_config_lock);
>> >> +	for (i = 0; i < CP2130_NUM_GPIOS; i++) {
>> >> +		chn = &chip->chn_configs[i];
>> >> +		ret += sprintf(out, "%d\t%d\t%d\t%d\t\t%d\t\t%d\t\t%s\t%d"
>> >> +			"\t\t%d\t\t\t%d\t\t%d\t\t'%s'\n",
>> >> +			i, chn->cs_en, chn->irq_pin, chn->clock_phase,
>> >> +			chn->polarity, chn->cs_pin_mode,
>> >> +			cp2130_spi_speed_to_string(chn->clock_freq),
>> >> +			chn->delay_mask, chn->inter_byte_delay,
>> >> +			chn->pre_deassert_delay, chn->post_assert_delay,
>> >> +			chn->modalias);
>> >> +		strcat(buf, out);
>> >> +	}
>
>> > This looks like a bunch of mostly very generic diagnostic data, if it's
>> > useful to have it should be added in the framework so it's available for
>> > all drivers.
>
>> The information is quite specific for the CP2130 so I cannot see how
>> this could fit into the SPI framework.
>
> All those delays, polarities and speeds look very generic.
>
>> We could use the timing information that comes with each SPI transfer to
>> setup the transport parameters of the chip, however, there are several
>> settings that may be incomplete. E. g. the IRQ pin. If the SPI slave
>> chip IRQ is connected to one of the GPIOs of CP2130 nobody knows upfront
>> which IRQ to configure for the slave chip driver. Same issue applies for
>> the CS pin, there is pre-numbered GPIO available for CS before the
>> CP2130 is plugged so you cannot setup other driver in advance.
>
> This is the same problem as all the plugin modules for non-enumerable
> buses like the Raspberry Pi have, they currently use things like DT or
> ACPI overlays to enumerate - there are some efforts at improving things
> as it's not ideal at the minute.  I'd expect you to be trying to use
> similar interfaces to them rather than inventing something completely
> driver specific, users shouldn't have to figure out some random driver
> specific interface for this.

Sorry, I was not aware of the APIs. This would mean I have to re-write a
relevant part of the driver and I can remove all the modalias loading
code as well. I will do the changes and try to support both, DT and ACPI
overlays. Thanks for your advice.

>
>> If the chip is permanently connected (e. g. in an embedded board, which
>> is unlikely because those often have host SPI ports anyway) we may have
>> an advantage from DT pre-configuration but I think this use-case is
>> quite unlikely and then there would still be the problem to know which
>> data is valid, the one that comes with the transfer message or the one
>> configured from sysfs.
>
> This is one reason why you shouldn't have a random sysfs interface.
>
>> >> +	/* iterate through all transfers */
>> >> +	list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
>> >> +		dev_dbg(&master->dev, "spi transfer stats: %p, %p, %d",
>> >> +			xfer->tx_buf, xfer->rx_buf, xfer->len);
>
>> > It's not clear to me why the driver can't use transfer_one() instead of
>> > transfer_one_message().
>
>> The documentation says that if both callbacks are provided the framework
>> will always use transfer_one_message() which I think is the superior
>> callback because we can keep the SPI configuration as it is if the same
>
> No, it's better to use transfer_one() if you can as it means there is
> less open coding of standard features in the driver.

Ok, understood. I will change this and keep the state of the last
transfer.

The changes, especially for DT and ACPI overlays will take me some time,
I will come back to you once this is done and well tested.

Regards
-Jochen

>
>> channel is used with subsequent transfers (performance) which we cannot
>> do for transfer_one(), at least if the driver should remain stateless
>> for the transfers.
>
> It's perfectly OK to cache the last settings that were sent to the
> hardware and only reconfigure if there's a change, several drivers do
> that already.

-- 
Henneberg - Systemdesign
Jochen Henneberg
Loehnfeld 26
21423 Winsen (Luhe)
--
Fon: +49 172 160 14 69
www: www.henneberg-systemdesign.com
