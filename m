Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1825DBDB
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgIDOe6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 10:34:58 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:32814 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgIDOev (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Sep 2020 10:34:51 -0400
IronPort-SDR: MRED0OCmkjLNXo8Kz0rHdFOUZXQAYc9NHl180JrekTcYuQIAO0vPEsXeL+umr+g/QzVPwBhdNR
 AvWaWeCdqCPGTYSKlqEeT3TN0J6ti8UmioQeIMFtFZIYdHtKh1UsAJm/Rzq79pijLpGE6jvnhj
 u6i0bm57/HjEYqmL9kug62dq9dpP0V+pOwd7HCpaVs8QxzFFbP4awbH0PWoU6KUuLnqkSi8vfk
 3gwt9F19U19ZWC35alSqQrEaPYSYrfZgWcEyo8Urfi03icVRs4KjoWtSEdcQvPyYWg9j3GzndC
 tRQ=
X-IronPort-AV: E=Sophos;i="5.76,389,1592863200"; 
   d="scan'208";a="13737379"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Sep 2020 16:34:43 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Sep 2020 16:34:43 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Sep 2020 16:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599230083; x=1630766083;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7XiVlDr00IMxMBe764lGNk5PWpuISV6o8DZWMwHMFg=;
  b=LkEW6cNWfD2yMDFHAcyzgn8dVUHnbsuMNQ93VYO2eFrGIavOcnEJ8XX7
   ck4AGrnqy10Y8t+ZwqL2XbOvRHgYB+IlKSI5XPSe0Oz9w3LjV5uIYMzUH
   prqIxqtcoQjLIo7noYIVp/yY02QHUaitpTfmW2ujDos3Px4Jsvxlo7gtS
   /aHkXkMr1a0WrK2tPsGeY5WQaYLViDDAcyD3NkXqqyVnwpJ9TN2CTQHSA
   ECeS/U4ep5JeepQdjp/p1ifeQf97EH7MxKeQNaS3UL3gTNTSMbitUMtaK
   Qv5VKPVpR0yxvwozdZL+Pc9tTpmuA/v7lLX/CRoRb2wD4CQluO5r9PeAm
   Q==;
IronPort-SDR: XWepbQyV2JQ+1ituWt8O4o77v0i8ltrFzVdO3CzJgRlRnMO1bNPMKAW/gXDaGQtRwqfihgutVX
 UoAMCc/OKxXSJ6NmGgesXMCjAjFNbnDJqT2kzVktpcuddkgFs13C71LDKHh7YJsO3U2PJiRmCl
 xUdRn3BMWQMq7OKTd5NskyELgH0o4NyMWVl6PcidcmvLop19HQXhXsr68n9Q3WO6NENrNxmLaz
 ExALDZnJ2W6IqYfSY09zWjnIwzY1JFn4yd4RyWtEWUOgg8nXfhhQuq0qu4aAAucqIZnEdUoh8t
 SSM=
X-IronPort-AV: E=Sophos;i="5.76,389,1592863200"; 
   d="scan'208";a="13737378"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Sep 2020 16:34:43 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 38FF9280065;
        Fri,  4 Sep 2020 16:34:43 +0200 (CEST)
Message-ID: <f753882996235439b9ef53747d24382e896dc4e7.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH] spi-imx: remove num-cs support, set
 num_chipselect to 4
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Sep 2020 16:34:43 +0200
In-Reply-To: <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
         <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
         <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 2020-09-04 at 10:57 -0300, Fabio Estevam wrote:
> On Fri, Sep 4, 2020 at 10:02 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > This would make num_chipselect default to 1 again (set by
> > __spi_alloc_controller()), breaking every i.MX board that uses more
> > than 1 native CS.
> 
> Which boards are that? Are you referring to non-DT i.MX boards?
> 
> If so, I have sent a patch removing all non-DT i.MX boards.
> 
> > I'm aware that using cs-gpios instead of native CS is probably a
> > good
> > idea in any case, as the native CS of this SPI controller is kinda
> > flaky (and at a glance it looks like all in-tree DTs do this; not
> > sure
> > about board files that don't use DTs?), but I'm not convinced that
> > breaking native CS support completely is desirable either.
> 
> Initial i.MX chips with this SPI IP had issues in using chip-select
> in
> native mode and GPIO chip-select has been used since them.
> 
> Do we have i.MX dts that make use of native chip select?

As mentioned in my previous mail, all in-tree DTS use cs-gpios (unless
I've overlooked something - I grepped for CSPIn_SSm pinmuxings), so
removing support for native CS should not break anything we know of.

Nevertheless, I don't see why we should deliberately remove the native
CS support - my understanding was that we try to avoid breaking changes
to DT interpretation even for unknown/out-of-tree DTS.

