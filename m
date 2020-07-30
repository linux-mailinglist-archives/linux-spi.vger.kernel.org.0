Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1058232C20
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jul 2020 08:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgG3GyR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jul 2020 02:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgG3GyQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Jul 2020 02:54:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E1020656;
        Thu, 30 Jul 2020 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596092056;
        bh=d2mGG9EZHjTB3Y/Qq+mlIWfyToju/xTDhzWBPh0dPi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNgL4iJrNhPxP84amUMEWzJvpIqTrTJPNZpqibJeVn+6nfEkqmMrF0aqAxtWBsbX5
         GmiV+b5XlJJ3+nuCOcfE6kKV5h85reJQTJg8rOboAHqhjoMgbkT6AKMNN4aPqVokp7
         ShP3e6+Aw7/+hl42kh12ZFMcxlMED0T1gX9AhXgk=
Date:   Thu, 30 Jul 2020 08:54:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix races on device removal
Message-ID: <20200730065406.GB3950394@kroah.com>
References: <cover.1594214103.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594214103.git.lukas@wunner.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jul 08, 2020 at 03:27:00PM +0200, Lukas Wunner wrote:
> Prevent dynamic SPI device addition below a controller which is
> being removed.  To do so, set the controller's "dead" flag using
> kill_device() (patch [3/3]).

Why is the SPI bus allowing this to happen?  Don't you have a per-bus
lock that can serialize all of this?

thanks,

greg k-h
