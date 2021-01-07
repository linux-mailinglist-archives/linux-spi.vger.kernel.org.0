Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F02ECC44
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAGJEb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 04:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbhAGJEa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 04:04:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3B5923120;
        Thu,  7 Jan 2021 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610010229;
        bh=7mRF/UpDXKObT3hyG6tl9Nq2g6HneEvAVqS1pFJMSNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfubH2QbRxm97gWiea7OI8eCNrJQXqnKPZuvX2Hk/3jvmv0QXbGtB0pNjb7NPeP71
         ivkbvCv7LOzWN6XM/9XhBiG1t3n74kiQPAywb9/FB8KM4dhn2F6nGAci4/9ttDf/qd
         sBkNQOjHQ2NSBRLmpwqjNs9zFeznyLLFfg5XQRwmcbow3V09yr800douq+8imqaLYv
         deuMXn53s9lTTPzOxD4m2oc1T2OMWEPKamXlozYwGga5HOJJxr+G0gmH3SgwhbjxXR
         M1ni6fgVjYLSU8bp4a0/wZFwGz0ZrimGSWwrigVFWZByFQW2JJhFP6PJaIKNI/owwS
         bu2n0dwRtJFUw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kxRCv-0003sb-Ul; Thu, 07 Jan 2021 10:03:50 +0100
Date:   Thu, 7 Jan 2021 10:03:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: Linux gnss driver SPI support?
Message-ID: <X/bOdQMe80v4N3AF@hovoldconsulting.com>
References: <CAJ+vNU1XJCisZWpr-huf5gt3V592gz8kX+VHga58iM-Kx+h5=Q@mail.gmail.com>
 <X/WdJ6WEWtK1zix+@hovoldconsulting.com>
 <CAJ+vNU3WyXT5ozp1mc2EnxHrPGxzEGy8Tt1sNVLV+5WSfeAA+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3WyXT5ozp1mc2EnxHrPGxzEGy8Tt1sNVLV+5WSfeAA+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 06, 2021 at 12:17:01PM -0800, Tim Harvey wrote:
> On Wed, Jan 6, 2021 at 3:21 AM Johan Hovold <johan@kernel.org> wrote:

> > Correct, there are currently no drivers supporting SPI and hence no
> > shared implementation either like there is for UART interfaces.
> >
> > The driver for your device would need to handle the SPI bits itself for
> > now. What kind of device is it?

> It is the u-blox ZOE-M8Q which has a UART as well as SPI/I2C/SQI
> interface. The particular board design we are working on is
> unfortunately out of UART's which is why we were looking at connecting
> it via SPI.

So we'd need to add support for the SPI interface to the ublox driver,
which is currently UART only.

> I did come across a posting about this [1] which uses a userspace app
> that creates a spy to pty bridge but it seems like they ran into some
> performance/latency issues.

Yeah, that is one of the problems that the gnss subsystem is meant to
solve; to handle the transport interface in the kernel and provide a
generic interface to user space.

Johan
