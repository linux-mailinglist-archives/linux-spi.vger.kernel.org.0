Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18948F687
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiAOLRt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Jan 2022 06:17:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46930 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiAOLRt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 15 Jan 2022 06:17:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C376DCE21A9;
        Sat, 15 Jan 2022 11:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA15C36AE3;
        Sat, 15 Jan 2022 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642245466;
        bh=Vf5Eyjo1dbWgWjNsGarwCBV+wXaZqgxxnpWbhlgmSpg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=ejKkeDN52k/rTwrCE0cl4ZS7XivgTMvuPSg+jiez+fECNMOWuthYT4wk9ywPlt4dX
         QpeXTavc/q1mJe+y7W7wRQXo0DFU8wk4ZYPMD58cZZstExj8wNbz+EXlGwMsDQA1vf
         g/B2LHm0UCcznSLAE1gzhDdq7g9XEh6YbK196txpNFJ/G8GeApTmwaaGm0V60ar8T0
         eJlMlNj0rDLRz98F+LiiGPHXIg8ZAJvDrU2w0XZYZRugp343JqCg3RbysfzqOr/F/J
         KH/ugcG3jDTTa+XleAdn8nQXsVyTIwxRYyzEaDWAbJf+4ioZ/ui5WFGVAcMdZfzI3F
         6YGd2My2lX72g==
References: <20211229231141.303919-1-dmanti@microsoft.com>
 <20211229231141.303919-6-dmanti@microsoft.com>
 <CAO-hwJJZUKfPd65ML3cm41Fw5fNtvMgbMK+KZQ5KnD7-MfDd9Q@mail.gmail.com>
 <MW2PR2101MB1065322A52B88BDBF0807058DA559@MW2PR2101MB1065.namprd21.prod.outlook.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Dmitry Antipov <dmanti@microsoft.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Antipov <daantipov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1 5/5] HID: add spi-hid, transport
 driver for HID over SPI bus
Date:   Sat, 15 Jan 2022 13:16:30 +0200
In-reply-to: <MW2PR2101MB1065322A52B88BDBF0807058DA559@MW2PR2101MB1065.namprd21.prod.outlook.com>
Message-ID: <87zgnx2qp6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi,

Dmitry Antipov <dmanti@microsoft.com> writes:
>> > +       /*
>> > +        * FIXME: below call returning 0 doesn't mean that the report descriptor
>> > +        * is good. We might be caching a crc32 of a corrupted r. d. or who
>> > +        * knows what the FW sent. Need to have a feedback loop about r. d.
>> > +        * being ok and only then cache it.
>> 
>> Shouldn't you check for the CRC before submitting to hid_parse_report then?
>
> I recently tested a touch digitizer firmware with a bungled report
> descriptor. Nothing in the HID stack returned an error, but the hidraw
> device was not installed. Short of traversing the /dev/ location I am
> not sure how to confirm that hid_add_device() did what we expect it to.
> 		
> We keep the device (/dev/hidraw# in our case) installed during suspend
> sessions (saves time and kernel memory on resumes from sleep), but if
> the report descriptor changes, its CRC will not match the cached one (we
> check in spi_hid_refresh_device_work) and we will reinstall the device,
> so we won't be surprised if the device starts sending unexpected
> reports.

note that the same behavior can potentially trigger after a FW upgrade
of the digitizer if either device or report descriptors change. That's
the only reason why the CRC exists today, so the driver can detect that
the other side "is another device".

-- 
balbi
