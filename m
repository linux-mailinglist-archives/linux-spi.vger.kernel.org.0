Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52B523B57E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Aug 2020 09:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgHDHUF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Aug 2020 03:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgHDHUE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Aug 2020 03:20:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2822076C;
        Tue,  4 Aug 2020 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596525604;
        bh=7o+GGNvYDggfVKcvkcydQ3oRMVae6I6vRgnD5cwx+us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKDvxR57uNwAMGXCyOCIcDA/gFDq7HoYaGpeThcisvT1vWFtMt4qHogJBwWgIQtnc
         QTLc74NNKzy7TR50E7sjibZuvF6MCzOmwm/Lf58+CYDWfIuufQZbytglAENI5P28R4
         GLUxw/UrBpLzEWXlxvttcvch64GF20xZ3Lau9bsA=
Date:   Tue, 4 Aug 2020 09:19:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: at25: allow page sizes greater than 16 bit
Message-ID: <20200804071945.GB1416416@kroah.com>
References: <20200727111218.26926-1-ceggers@arri.de>
 <9183924.TykLrII94J@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9183924.TykLrII94J@n95hx1g2>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 04, 2020 at 08:40:52AM +0200, Christian Eggers wrote:
> Ping?

It's the middle of the merge window now, I can't take any patches for
the next 2 weeks, sorry.  It is in my queue, and will be looked at after
5.9-rc1 is out.

thanks,

greg k-h
