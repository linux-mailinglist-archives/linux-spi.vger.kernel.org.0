Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C7188AE7
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgCQQoU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 12:44:20 -0400
Received: from foss.arm.com ([217.140.110.172]:40440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgCQQoU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Mar 2020 12:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC80EFEC;
        Tue, 17 Mar 2020 09:44:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315193F52E;
        Tue, 17 Mar 2020 09:44:19 -0700 (PDT)
Date:   Tue, 17 Mar 2020 16:44:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>, skakit@codeaurora.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
Message-ID: <20200317164417.GJ3971@sirena.org.uk>
References: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <20200317121018.GB3971@sirena.org.uk>
 <CAD=FV=VAeOYAG-R6aeAAoo7TsuvDBgNnqxn3XE2Mw3hwL1H7Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VAeOYAG-R6aeAAoo7TsuvDBgNnqxn3XE2Mw3hwL1H7Ew@mail.gmail.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 08:12:30AM -0700, Doug Anderson wrote:
> On Tue, Mar 17, 2020 at 5:10 AM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Mar 16, 2020 at 03:20:01PM -0700, Douglas Anderson wrote:

> >
> > Does this mean that there was an actual concrete message of type
> > CMD_NONE or does it mean that there was no message waiting?  If there
> > was no message then isn't the interrupt spurious?

> There is no message of type "CMD_NONE".  The "cur_mcmd" field is
> basically where in the software state machine we're at:

...

> ...so certainly if we see "cur_mcmd == CMD_NONE" in the interrupt
> handler we're in an unexpected situation.  We don't expect interrupts
> while idle.  I wouldn't necessarily say it was a spurious interrupt,
> though.  To say that I'd rather look at the result of this line in the
> IRQ handler:

>     m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);

> ...if that line returns 0 then I would be willing to say it is a
> spurious interrupt.

Right, that should return IRQ_NONE if there's nothing actually asserted.
I think you're right about the state machine though.

> C) Do we care to try to detect spurious interrupts (by checking
> SE_GENI_M_IRQ_STATUS) and return IRQ_NONE?  Right now a spurious
> interrupt will be harmless because all of the logic in geni_spi_isr()
> doesn't do anything if SE_GENI_M_IRQ_STATUS has no bits set.  ...but
> it will still return IRQ_HANDLED.  I can't imagine anyone ever putting
> this device on a shared interrupt, but if it's important I can detect
> this and return IRQ_NONE in this case in a v2 of this patch.

It's a good idea to return IRQ_NONE not just for the shared interrupt
case but also because it lets the error handling code in the genirq core
do it's thing and detect bugs - as seems to have happened here.  This
one was fairly benign but you can also see things like interrupts that
are constantly asserted by the hardware where we end up spinning in
interrupt handlers.

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5w/mAACgkQJNaLcl1U
h9DXgwf/e1aqKwe3QdhJTo3ZnebAawyLn7xfkYE0amZAh7GQzsbx+MJv7Ar9hAm2
QF8ke5T67rDag/wSDpjuuyWEgRLmmpDg78DZSNoKVgNubIFJago000bwhqkFfJJR
T4C5EPMvzEg9rDF7NvM4WI4pNsAeBHH3l0mxA1ZLHs8capjDYvjUpZQFBBwDjT6E
blROzd29hLzWlVs44H/3rAVcCpT11ChwSjq4haJ/dBBHe/ObAVWUVjU5rhtP3Uod
IHvnBRbWG+iY0g8CWsZSJb9mMklOHacgPMdlnumNiYpgvM4OffyhfXQ1EnNVT2YN
1qbOrLz1MqviNs0f4WL2+MyG57DoXA==
=5ZtU
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
