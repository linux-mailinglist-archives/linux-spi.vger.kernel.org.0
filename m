Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC51F7268
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFLDRl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 23:17:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:65274 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgFLDRl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 23:17:41 -0400
IronPort-SDR: AyviqZeyLy/9uK9pXCFejAOnOkxd3CC13g7Sh93dq9CZ1nlj647ES8x1rsZ3Xiet3QT4RvDDHl
 JTPMfq5Xjwrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 20:17:40 -0700
IronPort-SDR: KN7bzxKEh4cZLsbefEUgcLnsQhtAunIFUDN/Icmh7aTDoM/F6gro/2hD6XWje0UoT3/edvkjwn
 +g95BR4Kfcgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="296817894"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 20:17:38 -0700
Date:   Fri, 12 Jun 2020 11:14:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 5/6] spi: altera: move driver name string to header file
Message-ID: <20200612031403.GA21214@yilunxu-OptiPlex-7050>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-6-git-send-email-yilun.xu@intel.com>
 <20200611140301.GH4671@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611140301.GH4671@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 11, 2020 at 03:03:01PM +0100, Mark Brown wrote:
> On Thu, Jun 11, 2020 at 11:25:10AM +0800, Xu Yilun wrote:
> > This allows other driver to reuse the name string for spi-altera
> > platform device creation.
> 
> This is a very unusual thing to do, normally we just have the users use
> the strong directly.  It feels like if we are going to change this idiom
> we should do so globally but that seems like far more trouble thanit's
> worth.

Sure, I'll discard this patch and just use string for spi-altera device
creation.

Thanks,
Yilun.
