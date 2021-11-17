Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241CB453F9B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 05:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhKQEhk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 23:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhKQEhi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Nov 2021 23:37:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BCFA61155;
        Wed, 17 Nov 2021 04:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637123680;
        bh=UvK+WJZOj7kbGDT6VDZOQ6UuM6Yq4w5uG0salUh+u1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXKrNop+lqgEpu/Q5hLEdgJdXIvaifZwVU4C9EK3kLHFkxG6ULmKG25x36QhqpbUX
         KCTxhPgpSiET1xP8B7fwDNnMY4D/eIYeSFnwc1pEn4+bKf0fPacoc2YhHEbwxReSOX
         wWTEt+8KAJ8JkwJ0ZPVd0PITRETFMmBol/xiPVscjZ2FPXFuoNygcNJry/Sjd+ifwV
         mcPxGoGGJNX3L3wiHtEpn109IxiWXP4tbm3Jyg+k8iYSiCgWtc//JOaBgQXWqSRMuV
         MFvQ6L1GU+vAITWK9z+hLu4zpmQkHTWOHFrgvfnxBNAAguyywZvKicwQz1mDP6Rrmu
         33Xx4gbqXXyXA==
Date:   Wed, 17 Nov 2021 10:04:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] spi: spi-geni-qcom: Add support for GPI dma
Message-ID: <YZSGW7vNI04agVg3@matsya>
References: <20211020060954.1531783-1-vkoul@kernel.org>
 <CAD=FV=VDjqQsnGVOf0FPsk74xgP87iBnk3MznEi1TjTKHP0Ldw@mail.gmail.com>
 <YZPVB84Eq9Dn3Znv@matsya>
 <YZPfJtkvo3bsfaCg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZPfJtkvo3bsfaCg@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16-11-21, 16:41, Mark Brown wrote:
> On Tue, Nov 16, 2021 at 09:27:59PM +0530, Vinod Koul wrote:
> > On 03-11-21, 14:17, Doug Anderson wrote:
> 
> > > if (result->residue) {
> > >   dev_err(...);
> > >   return;
> > > }
> > > spi_finalize_current_transfer(...);
> 
> > Should we always call spi_finalize_current_transfer() ? This way we
> > timeout... What is the way to signal error has occurred..?
> 
> Yes, set an error in the transfer and then finalize it.

Sure will do, thanks for confirming Mark

-- 
~Vinod
