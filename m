Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAD25C420
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgICPEI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 11:04:08 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:9827 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgICN6U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Sep 2020 09:58:20 -0400
IronPort-SDR: PwSSrpM7beoRNGtbZuYVQYarDacF81+BP6yekLAu15x7XInnZ+j5yvbR+RmcJR4SgQGfMy3QxF
 +W1I13/hf7uv7PgjkRcXItnriXG56d2qnPNvuMDwP5TT2rKbRL87qo0YrJWVdCrbqnXg6xRfzf
 doKCClYldLzMX+mQPBcJnZA6Dvz+zQ5Lr1GCrroAPKS8Mx4cGGhMgKw87yxskV3KabPuiYNNeU
 HK/iHvecc8tGVcNFPfxJ45nNmcCZWPMtDaZYSvhFb43LTmeJBpaYKI6cYWI22gusuFIG8S9n+2
 A1k=
X-IronPort-AV: E=Sophos;i="5.76,386,1592863200"; 
   d="scan'208";a="13721334"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Sep 2020 15:40:44 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Sep 2020 15:40:44 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Sep 2020 15:40:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599140444; x=1630676444;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSRtsYjMIeQn6kkIpSqi/xNdAKBtKRUGER2IFcNijQk=;
  b=N8JPB2+7SiBeJrScJn+KM0GUbsfIXmUgpzkMlhWMhmo/yN4YxwRQf3cI
   HTBh2bWXK+2czsdjHkI4rSjEsXwlqaboxcmdup/N/drxkqC902yTb+js2
   PzhqWK+fPzszJlEd0Wg6Q/zcY2gguuBaQxmEhVUJUyyT27Xe6fsWd5nu/
   9NajEiQBmfnR/TSAaDJ020PyEaO5xl7rKZ8DkteUnsQBqF6Ic7ETDyavR
   ZnFZwsOBGLjv2K17N+0YrJTYmf0gJTj828ci3wlmlHqctSn7GAKCwkZoT
   Pkei9rNfLTeZ6hNJG2GAZEBNxq9lm/6C4hygxryfJbFqRpQykxDmuuwAo
   Q==;
IronPort-SDR: zDp6qokfh+UZ5a3ETjcvlv4kekHz7nAQLLDIdpowFcBTrgZGK7bVWsZawcpM6af3jkn2ZirSL+
 xiYF4B0FjTeQEOaqUrbDsjYDlp5zzNTt8x6A2qaU9TbnTj+m+d4F507FtMUS8rYhkK0r0FcaZ2
 3R3juBoV0vLvMpOzGa/ATiyM1uMEndtaz8TpDz+FLFU2/ic8Szsk318uheKdvVFW6bqVK1t0m7
 S++Z/We4I3MD7SRVT8cjBv34z3oZ3hm9NGMIgVKwU7J9voCKjrdHBBdawFMa00QeAu3dx5F4qY
 xn8=
X-IronPort-AV: E=Sophos;i="5.76,386,1592863200"; 
   d="scan'208";a="13721333"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Sep 2020 15:40:43 +0200
Received: from schifferm-ubuntu4 (unknown [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C88BD280065;
        Thu,  3 Sep 2020 15:40:43 +0200 (CEST)
Message-ID: <ce08696b6bf2b3eaa84d6f056f47a8240c7479f4.camel@ew.tq-group.com>
Subject: Re: spi-imx: correct interpretation of num-cs DT property?
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Sep 2020 15:40:43 +0200
In-Reply-To: <20200903132241.GB4771@sirena.org.uk>
References: <ecfa135b7b83a31bed821ec0740ab3cf1d39da15.camel@ew.tq-group.com>
         <20200903132241.GB4771@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2020-09-03 at 14:22 +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Sep 03, 2020 at 11:22:20AM +0200, Matthias Schiffer wrote:
> 
> > - If num-cs is set, use that
> > - If num-cs is unset, use the number of cs-gpios
> > - If num-cs is unset and no cs-gpios are defined, use a driver-
> > provided 
> > default (which is 3 for spi-imx; this matches the number of native
> > CS
> > pins in older implementations of this SPI controller; i.MX6 and
> > newer
> > support up to 4)
> 
> That sounds like what's expected, though we coould just skip the
> first
> step.
> 
> > Also, would it make sense to add num-cs to all DTS files for boards
> > that actually use fewer than 3 CS pins?
> 
> No, it was never a good idea to have that property in the first place
> and there should be no case where it helps anything.


Oh, thank you for the clarification.

As currently no in-tree DTs use the num-cs property for spi-imx and
it's not documented, should support for it be dropped from the driver
altogether?


> 
> > At the moment, the num-cs property is not explicitly documented for
> > the
> > spi-imx driver, although the driver understands it. I also
> > suggested to
> > add this to the docs, which Fabio didn't deem a good idea (I don't
> > quite understand the reasoning here - isn't num-cs generally a
> > useful
> > property to have?)
> 
> Could you explain what benefit you would expect having num-cs to
> offer?
> 
> * Unknown Key
> * 0x5D5487D0

