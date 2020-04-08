Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0DB1A2762
	for <lists+linux-spi@lfdr.de>; Wed,  8 Apr 2020 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgDHQmP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Apr 2020 12:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbgDHQmP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:42:15 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC9420769;
        Wed,  8 Apr 2020 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586364134;
        bh=dZflYwtdOE4WpeF55n3a5433aJ25TRS76smK0BBXLRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pX91x5p/ex8/LllfJiIeej2SPjWU/d1wcD7IAD90y5SaEHcvFWXo85xGJ6QFBMt1u
         ZiJGS26q3FFxWcH4/RHQQO1EgOWg5eAFYZtiHFCUXlkUkUnqv1soXL7RpTyJsVE5zd
         k0B9JNAg2QY85+hKcn3mTGujmOGS6djP0timfAgw=
Date:   Wed, 8 Apr 2020 18:42:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 21/35] docs: spi: spi.h: fix a doc building warning
Message-ID: <20200408184210.43c4411b@coco.lan>
In-Reply-To: <20200408161629.GC5177@sirena.org.uk>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
        <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
        <20200408154925.GA5177@sirena.org.uk>
        <20200408181154.6c290772@coco.lan>
        <20200408161629.GC5177@sirena.org.uk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Em Wed, 8 Apr 2020 17:16:29 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Wed, Apr 08, 2020 at 06:11:54PM +0200, Mauro Carvalho Chehab wrote:
> > Mark Brown <broonie@kernel.org> escreveu:  
> 
> > > Are you sure this is a sensible fix?  The following lines should be part
> > > of the documentation for transfer_one, will that be the case after your
> > > change?  
> 
> > Without that, Sphinx will warn and may produce something unexpected.  
> 
> Right, but if the warning is telling us something useful we want to
> handle it rather than just shutting it up.

True. Without adding the blank line, kernel-doc would output this as:

``transfer_one``
  transfer a single spi_transfer.
  - return 0 if the transfer is finished,
  - return 1 if the transfer is still in progress. When
    the driver is finished with this transfer it must
    call spi_finalize_current_transfer() so the subsystem
    can issue the next transfer. Note: transfer_one and
    transfer_one_message are mutually exclusive; when both
    are set, the generic subsystem does not call your
    transfer_one callback.

This would be parsed by Sphinx (newer versions) as if the second line:

	transfer a single spi_transfer.
	
would be a sort of subtitle that should be highlighted with a
vertical line before that. E. g. something equivalent to:

	 ============
	|transfer_one|

	 -------------------------------
	|transfer a single spi_transfer.|

	  - return 0 if the transfer is finished,
	  - return 1 if the transfer is still in progress. When
	    the driver is finished with this transfer it must
	    call spi_finalize_current_transfer() so the subsystem
	    can issue the next transfer. Note: transfer_one and
	    transfer_one_message are mutually exclusive; when both
	    are set, the generic subsystem does not call your
	    transfer_one callback.

Which is not the desired result.

Adding a blank line after it fixes the issue, making it produce the
expected output.

> 
> > If this patch is applied after 20/25, the output should produce the
> > correct result:  
> 
> > 	https://www.infradead.org/~mchehab/kernel_docs/driver-api/spi.html#spi-master-methods  
> 
> OK.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks,
Mauro
