Return-Path: <linux-spi+bounces-4521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D639693A6
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 08:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680561C21056
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 06:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930611CFEA0;
	Tue,  3 Sep 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oG3FmULU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCCA5F;
	Tue,  3 Sep 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344980; cv=none; b=N0gHN+LEyD4YZ8IbY5dNsb9toleLK6j3OtIdkIfPt2TN8nbTtJjZFNNJSHOhJQDW1mb5lOA3C+Qms7kkswpNN0MXfBED5FZiabHH4uEg1eiIrnACen1g1qCmeo/o4r9z4Fm4zSD1LgMyezWQrNoEVgJzu/pybKCI+EnqJNLZodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344980; c=relaxed/simple;
	bh=10+jhI/6ImbS3ZFkXBIC2SnK6R1MLziOBOnLAq6QFJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpIfWulgBdTjJnXxknH3RdGDuo8j4khIU8V4Ti9r7L/vuH0UfMkAxFsg+qWbgThJufSJfY92w1Lw+GcBPbNCg/cbEkl+DI1VIazdjdme2yiqA6SZZOBhLn6kg4caVFUVAc0/OaHPRWSwhaP5rzdwmTVEoBvo/cqNPT0ZXLTdBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oG3FmULU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66154C4CEC5;
	Tue,  3 Sep 2024 06:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725344980;
	bh=10+jhI/6ImbS3ZFkXBIC2SnK6R1MLziOBOnLAq6QFJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG3FmULU+/8/xnITT69vNFuShKPWGm96zQV0TF/w6tzAgzzHXvDwx63HT7w8KE85t
	 bNOAGaEjVYSwfyWZEpI7naviFAf3MZJNxzeVMPST9nd3zo3f1C066nUcxSuOGTJsh+
	 ZTDz6sUwC02OwBk9F41JpePipOzUUnXkfUDCerTM=
Date: Tue, 3 Sep 2024 08:29:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yang Ruibin <11162571@vivo.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <2024090358-settling-blimp-fb4c@gregkh>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
 <4e2ad62b-b11e-40db-9cd9-a26f7642c735@kernel.org>
 <b397b47e-f1fa-4589-9f07-d59ce743ec89@vivo.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b397b47e-f1fa-4589-9f07-d59ce743ec89@vivo.com>

On Mon, Sep 02, 2024 at 03:15:48PM +0800, Yuesong Li wrote:
> 
> 
> On 2024/8/31 1:10, Krzysztof Kozlowski wrote:
> > On 30/08/2024 10:55, Geert Uytterhoeven wrote:
> > > Hi Yang,
> > > 
> > > On Thu, Aug 29, 2024 at 5:35 AM Yang Ruibin <11162571@vivo.com> wrote:
> > > > Increase the reference count by calling pci_get_slot(), and remember to
> > > > decrement the reference count by calling pci_dev_put().
> > > > 
> > > > Signed-off-by: Yang Ruibin <11162571@vivo.com>
> > > 
> > > Thanks for your patch, which is now commit 8a0ec8c2d736961f ("spi:
> > > Insert the missing pci_dev_put()before return") in spi/for-next.
> > > 
> > > > --- a/drivers/spi/spi-pxa2xx-pci.c
> > > > +++ b/drivers/spi/spi-pxa2xx-pci.c
> > > > @@ -146,8 +146,10 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
> > > >          c->num_chipselect = 1;
> > > > 
> > > >          ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               pci_dev_put(dma_dev);
> > > 
> > > dma_dev is still uninitialized at this point.
> > > 
> > > >                  return ret;
> > > > +       }
> > > > 
> > > >          dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > > 
> > > dma_dev is initialized only here...
> > > 
> > > >          ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
> > > 
> > > ... and freed automatically by lpss_dma_put_device() in case of
> > > any later failures since commit 609d7ffdc42199a0 ("spi: pxa2xx-pci:
> > > Balance reference count for PCI DMA device") in v5.18.
> > > 
> > > > @@ -222,8 +224,10 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
> > > >          }
> > > > 
> > > >          ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               pci_dev_put(dma_dev);
> > > >                  return ret;
> > > > +       }
> > > > 
> > > >          dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
> > > >          ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
> > > 
> > > Likewise.
> > > 
> > > Hence this patch is not needed, and introduced two bugs.
> > 
> > Cc Greg, Jakub, David and Paolo,
> > 
> > It seems Vivo (at least two persons from vivo.com) is sending patches
> > generated through some sort of automation without really knowing what
> > they were doing. All of the patches look like innocent
> > cleanups/simplifications/fixes, but they do more.
> > 
> > This patch here looks like introducing two bugs.
> > 
> > These patches:
> > 1. https://lore.kernel.org/all/20240830033251.232992-1-yujiaoliang@vivo.com/
> > 
> > 2. https://lore.kernel.org/all/20240828122650.1324246-1-11162571@vivo.com/
> > (I sent a revert for this)
> > 
> > 3. https://lore.kernel.org/all/20240829072016.2329466-1-11162571@vivo.com/
> > 
> > and probably more...
> > 
> > introduce dev_err_probe() outside of probe path which is not desired,
> > because it marks a probed (working) device as deferred.
> > 
> > The patches look trivial and/or helpful, so people tend to accept them
> > through default trust.
> > 
> > I kindly suggest reverse - do not trust them by default and instead do a
> > thorough review before accepting any cleanup/trivial patch from @vivo.com.
> > 
> > Best regards,
> > Krzysztof
> > 
> > 
> 
> Dear Geert, Krzysztof, and the Linux Kernel Community,
> 
> I hope this message finds you well. My name is Yuesong Li, and I am writing
> on behalf of VIVO to sincerely apologize for the recent issues caused by the
> patches submitted by our team members. We deeply regret the problems that
> these submissions have introduced and the concerns they have raised within
> the community.
> 
> We recognize that the patches submitted were not up to the standards
> expected by the Linux kernel community. It is clear that our team members
> did not fully understand the implications of their contributions, leading to
> errors and the need for reverts. This is entirely our responsibility, and we
> are committed to ensuring that this does not happen again.
> 
> To address these issues, VIVO is taking the following steps:
> 
> 1.Training for employees: We are implementing a comprehensive training
> program for all employees who contribute to open source projects. This
> training will focus on understanding the intricacies of the Linux kernel,
> best practices for code submissions, and the importance of thorough testing
> and review before submitting patches.
> 
> 2.Enhanced Internal Review Process: Moving forward, we will enforce a more
> rigorous internal review process for all patches before they are submitted
> to the community. This will involve senior developers with experience in the
> open source community who will guide and review the work of less experienced
> contributors.
> 
> We value the open-source community and the collaborative spirit that drives
> it. VIVO is committed to contributing positively and responsibly moving
> forward. We kindly ask for your forgiveness for the mistakes we've made and
> your understanding as we take concrete steps to improve.
> 
> Thank you for your continued dedication to the Linux kernel, and please feel
> free to reach out if there are any further concerns or if you have
> suggestions on how we can better align with the community's expectations.

Thanks for doing this.  I've now dropped all pending vivo patches that
were in my review queues and will wait for this process to happen so
that they can be resubmitted after proper review by your internal
groups.

good luck!

greg k-h

