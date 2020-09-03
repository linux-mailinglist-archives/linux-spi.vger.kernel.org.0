Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04F225BE5C
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgICJW2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 05:22:28 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:25027 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgICJW0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Sep 2020 05:22:26 -0400
IronPort-SDR: pdeeloJ54OPb7Op3vser7vOX1+rTJtZZ1GuyM3nNgDq5DaI15qbA+VrXhJb6CcD2CzAnmnsr2Q
 kbXeIK/NpCuD0PeqRv0C1RRTeBv9Q4/Nto7p7Jsu1A0ClqPZ8yZBE8wu3gEUcqk819zASpMaaM
 jw3pbW1m5y/HAXOdsBgSzuGHIrH0arCFBgOQIvZKafKlMvjFi1k7yqQ4a/SuZAgWsswIp9AAUR
 bca/oTL1izsyZHhymZHBejCnyZ25MkrBeqUl+uNj+Ctf/Pdh6AyYk/DJJjKRyIt9cCf6CqG8/9
 Khg=
X-IronPort-AV: E=Sophos;i="5.76,386,1592863200"; 
   d="scan'208";a="13715495"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Sep 2020 11:22:22 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Sep 2020 11:22:22 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Sep 2020 11:22:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599124942; x=1630660942;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=s8a9bCwMLw0I2Lg6Q5nlLZokrFRZUgY6ANn6+w/KaeA=;
  b=lajE3Og93UGjbXpnM9WypLlNFCG3yMsuJso67FGdphE/DOqY+wLhfFZw
   va0UPc2q4auSq1gg2QoXIQf+PuJXT2/3ldbswl3qFVaeqqg0N3tiYt9eA
   VSGmvow3ZcZLlPTTWdKhgVapz4nWpMFHxovI0bZTrTsADj6+0h+6JxdEU
   JwV4UCbn6YlAbANiTzokSfjppVcFuoS7e1eiMS/xqA8+ymB49nFc28aAe
   9ORN/oQeKQMHtn+XBhwoZaUxoJG7s0CZOWEBOeCcJZqGUuCruc4oCa74E
   yDBXaXW792SxYmlV1VmHwIUSDBvttiG4UksIduTh+GgoJ+oJKc6mGsAap
   Q==;
IronPort-SDR: 5ZZ9GdricVMGj1PMBUoT8p4cMdUvNIAt2jbwWyvvaFmU+0w65okwpOLTfL2GYrRiYEI4NPufU1
 +e4pnUfmgRLxs/CR9I7+7k2Jt9G+Tae5lc6WgK6JH/l9+uoQGMVbx8Qk6dZFw1amQ+n6ZgD9jb
 t8WWe7/VvtN9SIBdSpsgjLA5s78mByhb24WDrEsDOXXdguMO3hGJdBDyNLZlfTsu5zQIJcwvTt
 DM6OOwKdjB2mk5HFvuINQ0HrN9/amRdyJXHi6bXE+h5hLtWqvt9KOjDsUh9E0SBTaz9Lbda7fj
 eII=
X-IronPort-AV: E=Sophos;i="5.76,386,1592863200"; 
   d="scan'208";a="13715494"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Sep 2020 11:22:22 +0200
Received: from schifferm-ubuntu4 (unknown [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5344C280065;
        Thu,  3 Sep 2020 11:22:22 +0200 (CEST)
Message-ID: <ecfa135b7b83a31bed821ec0740ab3cf1d39da15.camel@ew.tq-group.com>
Subject: spi-imx: correct interpretation of num-cs DT property?
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Sep 2020 11:22:20 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I've recently had a discussion about the correct way for an SPI driver
to handle the num-cs property: https://lkml.org/lkml/2020/8/25/184

Since 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert to GPIO
descriptors"), the logic of the spi-imx driver is somewhat confusing:
If fewer than 3 cs-gpios are defined, and no explicit num-cs property
exists, the driver will set num_chipselect to 3 by default, instead of
the number of cs-gpios entries.

To avoid having to specify num-cs when the number cs-gpios would
suffice, I suggested to modify the logic to the following:

- If num-cs is set, use that
- If num-cs is unset, use the number of cs-gpios
- If num-cs is unset and no cs-gpios are defined, use a driver-provided 
default (which is 3 for spi-imx; this matches the number of native CS
pins in older implementations of this SPI controller; i.MX6 and newer
support up to 4)

Also, would it make sense to add num-cs to all DTS files for boards
that actually use fewer than 3 CS pins?

At the moment, the num-cs property is not explicitly documented for the
spi-imx driver, although the driver understands it. I also suggested to
add this to the docs, which Fabio didn't deem a good idea (I don't
quite understand the reasoning here - isn't num-cs generally a useful
property to have?)

Kind regards,
Matthias

