Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD546CDF4
	for <lists+linux-spi@lfdr.de>; Wed,  8 Dec 2021 07:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhLHHCf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Dec 2021 02:02:35 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:41651 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhLHHCf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Dec 2021 02:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638946744; x=1670482744;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ys3xoYYUg/XfO70GY89Mdf0y1dgqNyrnRzK/L7xZwVs=;
  b=FwoPrpXVpmtkL3MqtiDLSUv61ZbQg4LgARWX1tgCIHPZ1FMpGN5LOf/B
   7TOBRPluMPo3pW171xPV9EyuoJ3SMZ9tuMaanHJfvdH0gz9kR/sXJ/2Sw
   pHbMnaDLal3co+Wh2AfVRhLrVYCdngMjk6u/DsR9bWJd10rul2Z+gBHVG
   98D48aZWkAUyJZmkQF7A1SmwD4nXkkHEzUuoZpLh5ngchB7pbiII5BKkv
   xwDlK3or9Yl1lM0x8Cs35MrqqUOfolVFUX2XGN2u/rF4Z+c6k8c0gEfzh
   Us+7mwj/O4yE0EdJig5Ax5zNrzHEv9UrUCSwniDcz5iWUsnDUbIH6s5rs
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,296,1631570400"; 
   d="scan'208";a="20913638"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Dec 2021 07:59:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Dec 2021 07:59:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Dec 2021 07:59:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638946743; x=1670482743;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ys3xoYYUg/XfO70GY89Mdf0y1dgqNyrnRzK/L7xZwVs=;
  b=oIrAN/gyPtqe2f2310fOgYVStvxLjgG4uZf54xDA/9Ya2XL/NCsy8zo7
   HhUZjOS2hB9OhJd1873411hZQxZh4AZ+qZ7nCjMMZROnXd25UaK7sA4rU
   PNMeFq6tV8vEIssIbolYo1NaCK7Vo9XaQkUU2MY1BZdKoX/q9yOTsjoxl
   GmpsJLL4xQr82Rxe8AV/12TZwJp5bQ0/GkFsPJMljtf7F8fIIhWq64yqy
   F535e+ZECbivKscCqn7wFY0F3E3ttEVh/cocKBeQnakNmbQV4KAmQcQ+g
   LNOvJyfkDmxwPaG8t6G2OiW3NWPefF5LWm+yzgTTXhP11MiAgGhurVOiG
   g==;
X-IronPort-AV: E=Sophos;i="5.87,296,1631570400"; 
   d="scan'208";a="20913637"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Dec 2021 07:59:02 +0100
Received: from steina-w (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D41E0280065;
        Wed,  8 Dec 2021 07:59:02 +0100 (CET)
Message-ID: <701d2fc1336de30789444e43efe98473fdeb554b.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 1/1] spi: lpspi: Add support for 'num-cs'
 property
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Date:   Wed, 08 Dec 2021 07:59:00 +0100
In-Reply-To: <Ya9aV9yAEt9aWUQz@sirena.org.uk>
References: <20211207104114.2720764-1-alexander.stein@ew.tq-group.com>
         <Ya9aV9yAEt9aWUQz@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Dienstag, dem 07.12.2021 um 12:57 +0000 schrieb Mark Brown:
> * PGP Signed by an unknown key
> 
> On Tue, Dec 07, 2021 at 11:41:14AM +0100, Alexander Stein wrote:
> 
> > +	if (!device_property_read_u32(&pdev->dev, "num-cs", &num_cs))
> > +		controller->num_chipselect = num_cs;
> > +	else
> > +		controller->num_chipselect = 1;
> 
> Do we need to use the num_cs property or can we just set num_chipselect
> to whatever the maximum value that can be set is?  I've never been 100%
> clear on why num-cs is in the binding.

I see two things which needs to be considered when setting
num_chipselect:

1.
The hardware limitation in the uC. The i.MX8XQP RM says:
>  The entire CS field is not fully supported in every LPSPI module
> instance. Refer to the chip-specific information for LPSPI.

This indicates there are some i.MX, not necessarily i.MX8 only, which
have more than 2 hardware chip selects. This might be set depending on
the compatible.

2.
The hardware limitation on the SOM and/or mainboard. E.g. even if the
uC supports 2 chip selects, only one may be available on the board
connector. This is something which can only be set in the DT.
This case is what this patch is about: Providing 2 hardware chip
selects, as the default (if unset) is just one.

Best regards,
Alexander


