Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F161F7294
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 05:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFLDmo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 23:42:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:48895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgFLDmo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 23:42:44 -0400
IronPort-SDR: 1/R4CD26iaCZs5H3z1+O3IlS+QcilTurTDG2c/TdZdzTHcWrJeLT0GeW1fiayJkX0mVdY0hnZp
 962ywb0ADKeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 20:42:44 -0700
IronPort-SDR: 5sIXoYvHr8ikEWq3P3TaJq59ARVq1sHC1zd9HcBa+qlmUJzsDMIwVRA1xEhgkODTYTXsRUzfmP
 6sHe1o01qkTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="448168243"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2020 20:42:41 -0700
Date:   Fri, 12 Jun 2020 11:39:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 6/6] spi: altera: fix size mismatch on 64 bit processors
Message-ID: <20200612033906.GB21214@yilunxu-OptiPlex-7050>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-7-git-send-email-yilun.xu@intel.com>
 <20200611110407.GE4671@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611110407.GE4671@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 11, 2020 at 12:04:08PM +0100, Mark Brown wrote:
> On Thu, Jun 11, 2020 at 11:25:11AM +0800, Xu Yilun wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > The spi-altera driver was originally written with a 32
> > bit processor, where sizeof(unsigned long) is 4.  On a
> > 64 bit processor sizeof(unsigned long) is 8.  Change the structure
> > member to u32 to match the actual size of the control
> > register.
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > ---
> 
> You've not provided a Signed-off-by for this, I can't do anything with
> it.  For details on what Signed-off-by means and why it's important
> please see Documentation/process/submitting-patches.rst.

Thanks for your explanation. I'll add my Signed-off-by.
