Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1822D6F9
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jul 2020 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGYLHg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Jul 2020 07:07:36 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:52761 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgGYLHg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Jul 2020 07:07:36 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 327BC30000D16;
        Sat, 25 Jul 2020 13:07:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EE7682CCD1; Sat, 25 Jul 2020 13:07:33 +0200 (CEST)
Date:   Sat, 25 Jul 2020 13:07:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, 0day robot <lkp@intel.com>,
        lkp@lists.01.org
Subject: Re: [driver core] e3b1cb5c89:
 WARNING:possible_recursive_locking_detected
Message-ID: <20200725110733.u6hi2tz3rmvpcy6s@wunner.de>
References: <f2d349b5ba67b5ca70cb19577725167642eb69c5.1594214103.git.lukas@wunner.de>
 <20200724142950.GG1850@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724142950.GG1850@shao2-debian>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 24, 2020 at 10:29:50PM +0800, kernel test robot wrote:
> commit: e3b1cb5c896ba748d8f848238c8ea1f89520bde3 ("[PATCH 3/3] driver core: Avoid adding children below a dead parent")
[...]
> [    1.392584] WARNING: possible recursive locking detected
> [    1.393350] 5.8.0-rc3-00011-ge3b1cb5c896ba7 #1 Not tainted
> [    1.393350] --------------------------------------------
> [    1.393350] swapper/0/1 is trying to acquire lock:
> [    1.393350] ffff88841fc6ff70 (&dev->p->dead_sem){.+.+}-{3:3}, at: __device_attach+0x51/0x1a0
> [    1.393350] 
> [    1.393350] but task is already holding lock:
> [    1.393350] ffff888107f42770 (&dev->p->dead_sem){.+.+}-{3:3}, at: device_add+0xf8/0x890

False positive:

__device_attach() takes a device's dead_sem whereas device_add() takes
the *parent's* dead_sem.  But lockdep thinks they're the same because
they're in the same lock class.

We would normally see the same lockdep splat for device_lock() but
commit 1704f47b50b5 silenced it by assigning device_lock() to the
novalidate class.

I could silence this lockdep splat by assigning dead_sem to the
novalidate class as well.  But I also have an idea how we could
fix it properly by introducing a per-device class for bus_types
that need it and by putting the device_lock, dead_sem etc in
separate subclasses within that per-device class.

Any preference as to which solution I should pursue?
Any thoughts on this series in general?
Does the newly introduced dead_sem evoke approval or rejection?
Anyone?

Thanks,

Lukas
