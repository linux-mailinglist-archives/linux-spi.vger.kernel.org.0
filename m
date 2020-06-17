Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CFD1FC9D9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jun 2020 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgFQJau (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jun 2020 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJau (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 05:30:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EEC061573;
        Wed, 17 Jun 2020 02:30:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jlUP8-0005no-6P; Wed, 17 Jun 2020 11:30:46 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7FB37101548; Wed, 17 Jun 2020 11:30:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] genirq: Do not test disabled IRQs with DEBUG_SHIRQ
In-Reply-To: <20200616103956.GL4447@sirena.org.uk>
References: <1592208439-17594-1-git-send-email-krzk@kernel.org> <1592208439-17594-3-git-send-email-krzk@kernel.org> <20200615120844.GL4447@sirena.org.uk> <CAJKOXPfEpLN9jS11WW367Na3Ukfi8p3urKDcJoafg9dHuCDSUA@mail.gmail.com> <20200616103956.GL4447@sirena.org.uk>
Date:   Wed, 17 Jun 2020 11:30:44 +0200
Message-ID: <87mu52ca4b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:
> On Tue, Jun 16, 2020 at 12:11:17PM +0200, Krzysztof Kozlowski wrote:
>> On Mon, Jun 15, 2020 at 01:08:44PM +0100, Mark Brown wrote:
>> > On Mon, Jun 15, 2020 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
>> > > Testing events during freeing of disabled shared interrupts
>> > > (CONFIG_DEBUG_SHIRQ) leads to false positives.  The driver disabled
>> > > interrupts on purpose to be sure that they will not fire during device
>> > > removal.
>
>> > Surely the whole issue with shared IRQs that's being tested for here is
>> > that when the interrupt is shared some other device connected to the
>> > same interrupt line may trigger an interrupt regardless of what's going
>> > on with this device?
>
>> Yes. However if that device disabled the interrupt, it should not be
>> fired for other users. In such case the testing does not point to a
>> real issue.
>
> To be honest I'd say that if you're disabling a shared interrupt that's
> a bit of an issue regardless of anything else that's going on, it'll
> disrupt other devices connected to it.

Correct.

Shared interrupts are broken by design and I really can't understand why
hardware people still insist on them.

Thanks,

        tglx


