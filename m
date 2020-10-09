Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91772891A9
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbgJITUb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 15:20:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33373 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388558AbgJITUb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Oct 2020 15:20:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C9A9323E53;
        Fri,  9 Oct 2020 21:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1602271228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BzP0pQ1Db7rSbyWi/g0zS5ugUBf9jywudEZzZsDAo8=;
        b=QeAMkGL61BLBvwdOfo+E/KVs5EKhkV+4iSy/1gZeYFmNwkMhC2zcdG2qUkYucwZyeiTY2G
        QNXF4PVJ5l+L610D8n69ZLMUbaiQJLIlwLQEFE6HmldpFSp9SsGoMZqvw+a1Fq8wpOo1tJ
        cbNOmz7Hzqpea59AKdSr8Mdo7ehKYHg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Oct 2020 21:20:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-spi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH v3] spi: fsl-dspi: fix NULL pointer dereference
In-Reply-To: <CA+G9fYsOENcQHvkPvxFh6TnwH7-LF6pweumiFK+S=+5yXVyUaw@mail.gmail.com>
References: <20200928085500.28254-1-michael@walle.cc>
 <CA+G9fYsOENcQHvkPvxFh6TnwH7-LF6pweumiFK+S=+5yXVyUaw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a98840cfad9ab13dfbad71bc100bc339@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-10-09 13:01, schrieb Naresh Kamboju:
> On Mon, 28 Sep 2020 at 14:26, Michael Walle <michael@walle.cc> wrote:
>> 
>> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in 
>> remove
>> path") this driver causes a kernel oops:
> 
> FYI,
> This reported issue is now happening on Linus's master 5.9.0-rc8 on 
> arm64
> nxp-ls2088 devices.

Yep, Kontron sl28 is also broken on the latest 5.9-rc8. Somehow
   commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove 
path")
made it into 5.9-rc7 but this fix didn't.

-michael
