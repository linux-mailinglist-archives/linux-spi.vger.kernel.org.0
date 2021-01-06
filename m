Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A592EBD16
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFLVy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 06:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbhAFLVx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 Jan 2021 06:21:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF87322B37;
        Wed,  6 Jan 2021 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609932073;
        bh=+wHV95cjtd29O/6YjPf4mbiYORoQZumDE8X6pwT66Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3NLj6sMllngqAoLruvI8qZwDv3d/NNNcI+C4b/LDjHL/U6HZCCV+bOg8WMklIs6E
         /yGQaDfuXmLoD3im1sSlyqkNOjEEY2iwSyCk2KfxQbxufZDnri340dMzJcwwJOx1gj
         yoiSWD5rvNyr+gKAfwzVlp4YxZWHpehqAilpnFihF7wn8go+Yt/Y9WTTTZwgNexZ2C
         05xGKrUg0gwhMqWMCPhqKvYfoBinZruuUHx5F8dYMx1hlRhSmgwZ1u+O2JdyQriLJM
         V/U9chsfMVtfw9pac6QOLANzGQQwy/8++X1GZ2pKPYAip7RjzHPdMRFz9zJBXbvZOd
         dBRWQGfLHkTFw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kx6sJ-00074Q-Pk; Wed, 06 Jan 2021 12:21:12 +0100
Date:   Wed, 6 Jan 2021 12:21:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: Linux gnss driver SPI support?
Message-ID: <X/WdJ6WEWtK1zix+@hovoldconsulting.com>
References: <CAJ+vNU1XJCisZWpr-huf5gt3V592gz8kX+VHga58iM-Kx+h5=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1XJCisZWpr-huf5gt3V592gz8kX+VHga58iM-Kx+h5=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 05, 2021 at 10:23:43AM -0800, Tim Harvey wrote:
> Johan,
> 
> I have noticed you maintain a gnss receiver subsystem and according to
> the device-tree binding Documentation it looks like it supports SPI
> but I'm not seeing any code support for SPI. Am I missing something or
> would that support need to be added for use?

Correct, there are currently no drivers supporting SPI and hence no
shared implementation either like there is for UART interfaces.

The driver for your device would need to handle the SPI bits itself for
now. What kind of device is it?

Johan
