Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390231BA54C
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgD0Np7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 09:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0Np7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Apr 2020 09:45:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B69E20656;
        Mon, 27 Apr 2020 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587995158;
        bh=3MxQcvVPHDNmD2p3N2l3hfzoQ2koesDzgeGkr1Fk32M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAIy47B/YDVL5Danw8xD23Ld34OvOTbTPmrU/CI5goQI1xMYPAKcvp0+SjisS199p
         qmRXB54E8vvldxhf0QYIW0zhEexGHSX1QFT/JXVjmO09RIJZYKvWxGv9YdEyy/LnMj
         t5Jj075Uyb2n5/Arr1e4H1EPdyWv1EGzaEEXFzkE=
Date:   Mon, 27 Apr 2020 14:45:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.schwierzeck@gmail.com, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
Message-ID: <20200427134555.GC4383@sirena.org.uk>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <20200424112505.GD5850@sirena.org.uk>
 <616a5419-add3-085e-32dc-c83d9d975725@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <616a5419-add3-085e-32dc-c83d9d975725@linux.intel.com>
X-Cookie: If your bread is stale, make toast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2020 at 02:01:29PM +0800, Dilip Kota wrote:
> On 4/24/2020 7:25 PM, Mark Brown wrote:
> > On Fri, Apr 24, 2020 at 06:42:30PM +0800, Dilip Kota wrote:

> > > Synchronize tx, rx and error interrupts by registering to the
> > > same interrupt handler. Interrupt handler will recognize and process
> > > the appropriate interrupt on the basis of interrupt status register.
> > > Also, establish synchronization between the interrupt handler and
> > > transfer operation by taking the locks and registering the interrupt
> > > handler as thread IRQ which avoids the bottom half.
> > > Fixes the wrongly populated interrupt register offsets too.

> > This sounds like at least three different changes mixed together in one
> > commit, it makes it quite hard to tell what's going on.  If nothing else
> > the conversion from a workqueue to threaded interrupts should probably
> > be split out from merging the interrupts.

> While preparing the patches, i got puzzled to go with separate patches (for
> threaded interrupts, unified interrupt handler and fixing the register
> offset) or as a single patch!!.

> Finally i choose to go with single patch, because establishing
> synchronization is the major reason for this change, for that reason
> threaded interrupts and unified interrupts changes are done. And the fixing
> offset is a single line change, so included in this patch itself. And, on a
> lighter note, the whole patch is coming under 45 lines of code changes.
> Please let me know your view.

The single line change to fix the offset sounds like an especially good
candidate for splitting out as a separate patch.  It's not really about
the number of lines but rather complexity.

> > > -static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
> > > +static irqreturn_t lantiq_ssc_err_interrupt(struct lantiq_ssc_spi *spi)
> > >   {
> > > -	struct lantiq_ssc_spi *spi = data;
> > >   	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
> > > -	if (!(stat & LTQ_SPI_STAT_ERRORS))
> > > -		return IRQ_NONE;
> > > -

> > Why drop this?

> lantiq_ssc_err_interrupt() getting called, only if LTQ_SPI_IRNEN_E is set in
> the interrupt status register.
> Once the 'LTQ_SPI_IRNEN_E' bit is set, there is no chance of all error bits
> being unset in the SPI_STAT register, so the 'if condition' will never be
> successful. Hence dropped it.

So this is another separate change and TBH it doesn't seem like a huge
win in that it's still potentially adding a bit of robustness.

> > It's not clear to me that it's a benefit to combine all the interrupts
> > unconditionally - obviously where they're shared we need to but could
> > that be accomplished with IRQF_SHARED and even if it can't it seems like
> > something conditional would be better.

> Lets take a case where Tx/Rx transfer interrupt got triggered and followed
> by error interrupt(before finishing the tx/rx interrupt execution) which is
> very less likely to occur, unified interrupt handler establishes
> synchronization.
> Comparatively, unified interrupt handler is better for adding support to the
> latest SoCs on which SPI have single interrupt line for tx,rx and errors.
> On basis of these two points i felt to go with unified interrupt handler.

Does the mutex not do this regardless of how the interrupt handlers are
wired up?

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6m4hIACgkQJNaLcl1U
h9BnXQf/cy3IrY0a7wiBzhsjOU1o662IOJa9R5tJGhOl2+2vj11ySHT72XO3oZ38
DAm4j9nidLgnQ1548Gw/BDXoKPTDm0A44sV9T5ENZhaq0pVtoLbdoLrJQvz+++Bh
pLszD/QwvRDiLkovRBM2HuaA/vNwNkgHc93V7qlMuTLnnwZgW7BfJB9NN4uUF7i0
46QfNFq2WsFHJ4pteRM4WfN22bzFOYE7W0Phf4wo+jDZY0SskUi1Ec+oMVU3nnWM
6qo0Vlvfflv/1nV0Z4KwMu00C0f1cJce5eLvPUiUbtYTxxJhOk8aSPxk465Agt9L
R6z2pQAwgrBR0K/in79rKpB36BMApQ==
=WBop
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
