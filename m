Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3110118570
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEIGc1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 02:32:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfEIGc1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 02:32:27 -0400
Received: from maxwell ([109.41.64.220]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mv2l4-1gXcRR1WgS-00qxHs; Thu, 09
 May 2019 08:32:21 +0200
References: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com> <1557144380-19935-2-git-send-email-jh@henneberg-systemdesign.com> <20190508071812.GS14916@sirena.org.uk>
From:   Jochen Henneberg <jh@henneberg-systemdesign.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Added driver for CP2130 USB-to-SPI bridge
In-reply-to: <20190508071812.GS14916@sirena.org.uk>
Date:   Thu, 09 May 2019 08:32:20 +0200
Message-ID: <87sgto16kr.fsf@henneberg-systemdesign.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:QZFpnL2lm9DCIjlRTQFt39d16w9tfXCo2zurUnmEXky5rtjGBWh
 XWhEpkLl5bTCR7nC7CAioMVaX6LKpB/JBy7EbQjt1Q9hVCYy5q0cLCxbpNiSKA54Bm/nwiy
 ERtDwT3sy/CY6qcNbbM7G+KqW/9X/stxF+IkKyxK7z9P+cmoByT8nuFsXv0Zx3E2ec9MBYL
 Ch3O3OF1O9p3hooQf7jVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MMF77e+hpIE=:RurB1j7jD6P7LOse0i0cPd
 K7IoL/8YiDy4k2I0X3lt6xgZqv7avEmm+f9nRfLQQf1dfBPIkBEbQo9/pi0Nd/W3ZJIvZrD6B
 FJMVgaUrXg0Zuv5D5Fq6fEdudOOGpXt4ZP4r+01VoHwnw8Yy5vgjcrJdBLZRvAKpzBopq6ZQq
 ywWXFNAwZoj//O5i4uKY06msIFLKOeq+mBS2CDb90PmPGoAK0zhxFoqSkEy4higeyTWFXj2WK
 2nKsGovUtalrbYWCtCLt7DPYKOST8gKlxrXQSOrVIEHBB1ivNDqJSrhtBD4q23XG/TlBDA/4I
 qj0fSysA2oo7mt7AoApjkASWmUEBqQ75pMTJBBKGA3tv/ynKG6przG6oRymS3KVfkJQ6GtMCA
 K4s0ldd1EAXbDSV822UNV5+cQLmCGsDKLJrrxM+Y72ldliBcpV51IOotwEMPxNF4IwQkuzZbP
 gIDpkXlSr6DvUCB640WIr/P+HqU3GpJz2UhYcCFRvh2URZ/NFQTHT7+rorPehcWxqXCavcZO1
 zrue2kdGJ1yLZBMEhlfqThWH0YuChRaYdFcieqBEsCOkccZ73ow6eAOlXQhQbaf9Rr03SF0Oi
 lXnwY0KF3wBo+w3MLY58uZjUnWCgUriw/oB9k0fvXslE5YvRqu99R6DpgRPdFpB2vuewUSnlf
 EwNAEObTfWb53RdduVVsZd45MNjEOM54wCzcndUiBve30M7eb7vHWhHbQeJ5r0cAQa+yUbg+1
 iXKuf342JV+YOQS3FAA6AcqsC7rPwJ6OW9CPGfqKn5DDd8F/E2vIMHByRza3WxFY4QPR7Kvqn
 mGB7SMI
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:
> On Mon, May 06, 2019 at 02:06:20PM +0200, Jochen Henneberg wrote:
>
> This driver has huge amounts of non-standard interfaces in it,
> especially the userpace ABI it adds.  It would be a lot easier to review
> if it were split up so that it's a series where the core SPI
> functionality is added initially and then other things were layered on
> top as additional patches.

Will do that once the open issues have been clarified (see comments below).

>
>> @@ -0,0 +1,1672 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Kernel driver for Silicon Labs CP2130 USB-to-SPI bridge.
>> + *
>> + * Copyright (C) 2019 Jochen Henneberg (jh@henneberg-systemdesign.com)
>> + */
>
> Please keep the entire comment a C++ comment, it makes things look more
> intentional.

I fixed that.

>
>> +/* Prototypes */
>> +static int cp2130_probe(struct usb_interface *intf,
>> +			const struct usb_device_id *id);
>> +static void cp2130_disconnect(struct usb_interface *intf);
>
> These forward declarations are really weird in a Linux driver, normally
> things like probe() are defined at the bottom of the driver just before
> the driver structure which also usually goes at the end.
>
>> +/* USB device functions */
>> +static struct usb_driver cp2130_driver = {
>> +	.name                 = "cp2130",
>> +	.probe                = cp2130_probe,
>> +	.disconnect           = cp2130_disconnect,
>> +	.suspend              = NULL,
>> +	.resume               = NULL,
>> +	.reset_resume         = NULL,
>> +	.id_table             = cp2130_devices,
>> +	.supports_autosuspend = 0,
>> +};
>
> Static variables are initialized to 0 by default, no need to explicitly
> do that.

I fixed that.

>
>> +static int __init cp2130_init(void)
>> +{
>
> module_usb_driver().

Fixed that.

>
>> +static int cp2130_spi_setup(struct spi_device *spi)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void cp2130_spi_cleanup(struct spi_device *spi)
>> +{
>> +}
>
> Omit empty functions.  If the framework won't let you omit empty
> functions they probably can't safely be empty.

I removed the empty functions. Most of the things that happen there need
information from platform data or DT which would not be available for
CP2130.

>
>> +	ret = sprintf(out, "channel\tcs_mode\tirq_pin\tclock_phase\tpolarity"
>> +		"\tcs_pin_mode\tclock_freq\tdelay_mask"
>> +		"\tinter_byte_delay\tpre_delay\tpost_delay"
>> +		"\tmod_alias\n");
>> +	strcat(buf, out);
>> +	mutex_lock(&chip->chn_config_lock);
>> +	for (i = 0; i < CP2130_NUM_GPIOS; i++) {
>> +		chn = &chip->chn_configs[i];
>> +		ret += sprintf(out, "%d\t%d\t%d\t%d\t\t%d\t\t%d\t\t%s\t%d"
>> +			"\t\t%d\t\t\t%d\t\t%d\t\t'%s'\n",
>> +			i, chn->cs_en, chn->irq_pin, chn->clock_phase,
>> +			chn->polarity, chn->cs_pin_mode,
>> +			cp2130_spi_speed_to_string(chn->clock_freq),
>> +			chn->delay_mask, chn->inter_byte_delay,
>> +			chn->pre_deassert_delay, chn->post_assert_delay,
>> +			chn->modalias);
>> +		strcat(buf, out);
>> +	}
>
> This looks like a bunch of mostly very generic diagnostic data, if it's
> useful to have it should be added in the framework so it's available for
> all drivers.

The information is quite specific for the CP2130 so I cannot see how
this could fit into the SPI framework.

>
>> +static ssize_t channel_config_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t count)
>> +{
>
> This is adding a completely non-standard ABI for configuring things -
> why not use standard interfaces?
>
>> +static DEVICE_ATTR_RW(channel_config);

I think this needs some more explanation about the nature of the
chip. As it is a USB device and the SPI performance is not as good as it
would be with a SOC SPI port the chip is typically used for prototyping
or for bus testers, e. g. CAN or ARINC429 chips that need an SPI bus.

We could use the timing information that comes with each SPI transfer to
setup the transport parameters of the chip, however, there are several
settings that may be incomplete. E. g. the IRQ pin. If the SPI slave
chip IRQ is connected to one of the GPIOs of CP2130 nobody knows upfront
which IRQ to configure for the slave chip driver. Same issue applies for
the CS pin, there is pre-numbered GPIO available for CS before the
CP2130 is plugged so you cannot setup other driver in advance.

If the chip is permanently connected (e. g. in an embedded board, which
is unlikely because those often have host SPI ports anyway) we may have
an advantage from DT pre-configuration but I think this use-case is
quite unlikely and then there would still be the problem to know which
data is valid, the one that comes with the transfer message or the one
configured from sysfs.

I have added a mechanism to provide driver platform data for the slave
chip via sysfs which is a bit of a hack but some slave drivers need the
platform data to work without modifications.

What happens is that if the CP2130 is plugged you need to run some udev
actions to setup the communication parameters, the interrupt GPIOs, the
SPI slave chip platform data (maybe) and modalias along with some pin
configurations. If somebody builds a test adapter with the CP2130 it
should be shipped with udev rules and adapter configuration scripts.

The only reason why I put all this into the driver and not into some
userspace implementation (libusb) is that this drivers allows to use
and/or develop/debug SPI slave chip drivers, e. g. on a laptop where no
host SPI port is available.

>
> Device attributes in sysfs should follow sysfs rules, including having
> just a single value per file to ease machine parsing.
>
>> +out:
>> +	return (!ret ? len : ret);
>
> Please write normal conditional statements to make things easier for
> people reading the driver.

Fixed that.

>
>> +	mutex_lock(&dev->usb_bus_lock);
>
> What is this protecting?

To be perfectly honest this is just a precaution. Polling GPIO states or
writing the OTP ROM may interfere with SPI communication (I did not
really test that nor does the datasheet provide sufficient information
if that matters or not) so I wanted to be save that every action that
needs multiple USB transfers is protected against other multi USB
transfers. I will try if this really is an issue and remove the lock if
possible.

>
>> +	/* iterate through all transfers */
>> +	list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
>> +		dev_dbg(&master->dev, "spi transfer stats: %p, %p, %d",
>> +			xfer->tx_buf, xfer->rx_buf, xfer->len);
>
> It's not clear to me why the driver can't use transfer_one() instead of
> transfer_one_message().

The documentation says that if both callbacks are provided the framework
will always use transfer_one_message() which I think is the superior
callback because we can keep the SPI configuration as it is if the same
channel is used with subsequent transfers (performance) which we cannot
do for transfer_one(), at least if the driver should remain stateless
for the transfers.

Regards
-Jochen
