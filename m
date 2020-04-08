Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28281A26EF
	for <lists+linux-spi@lfdr.de>; Wed,  8 Apr 2020 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgDHQL7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Apr 2020 12:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgDHQL7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:11:59 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF55B20730;
        Wed,  8 Apr 2020 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586362319;
        bh=vR3Za9vsIQ5x9x78qsSEKyr+Z7YV/dYZe3ACWer/qqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tSd41lOG+oThYoZPZT9m4TZJz0Eta+Mu+uT/MUzOHL88hVrxrf/1uRkmSixCPNRMc
         1FoQlpzzPq2RDGhFJAUeLZip9yRA1lLb8HekKb1p0k0JrWFhTA3i+a0YUrfvxuxqVY
         BHF1/kB28BK5RGQf0YVeOPJHmtZn0BARF8bRKF5Y=
Date:   Wed, 8 Apr 2020 18:11:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 21/35] docs: spi: spi.h: fix a doc building warning
Message-ID: <20200408181154.6c290772@coco.lan>
In-Reply-To: <20200408154925.GA5177@sirena.org.uk>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
        <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
        <20200408154925.GA5177@sirena.org.uk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Em Wed, 8 Apr 2020 16:49:25 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Wed, Apr 08, 2020 at 05:46:13PM +0200, Mauro Carvalho Chehab wrote:
> > We need to add a blank line to avoid this warning:
> > 
> > 	./include/linux/spi/spi.h:401: WARNING: Unexpected indentation.  
> 
> >   * @transfer_one: transfer a single spi_transfer.
> > + *
> >   *                  - return 0 if the transfer is finished,
> >   *                  - return 1 if the transfer is still in progress. When
> >   *                    the driver is finished with this transfer it must  
> 
> Are you sure this is a sensible fix?  The following lines should be part
> of the documentation for transfer_one, will that be the case after your
> change?

Without that, Sphinx will warn and may produce something unexpected.

Yet, right now, kernel-doc is not prepared for the above change.
When kernel-doc finds a blank line, it just assumes that the
remaining content is part of the description. That is due to some
laziness on its parser.

This is fixed by patch 20/35 on this series:

	Subject: [PATCH 20/35] docs: scripts/kernel-doc: accept blank lines on parameter description

If this patch is applied after 20/25, the output should produce the
correct result:

	https://www.infradead.org/~mchehab/kernel_docs/driver-api/spi.html#spi-master-methods

Thanks,
Mauro
