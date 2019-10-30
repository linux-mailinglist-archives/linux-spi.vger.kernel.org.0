Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F151E9B12
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 12:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ3Lrp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 07:47:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:26170 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3Lrp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Oct 2019 07:47:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 04:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="198655417"
Received: from mylly.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2019 04:47:43 -0700
Subject: Re: [PATCH] spi: dw: Remove runtime PM enable/disable from common
 part of the driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20191030113137.15459-1-jarkko.nikula@linux.intel.com>
 <20191030113334.GA6693@sirena.co.uk>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <57a61e72-f815-f5ef-885a-cd112c471140@linux.intel.com>
Date:   Wed, 30 Oct 2019 13:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030113334.GA6693@sirena.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/30/19 1:33 PM, Mark Brown wrote:
> On Wed, Oct 30, 2019 at 01:31:37PM +0200, Jarkko Nikula wrote:
>> Committed version of the commit b9fc2d207e54 ("spi: dw: Move runtime PM
>> enable/disable from common to platform driver part") does not include by
>> some reason changes to drivers/spi/spi-dw.c that were part of the original
>> patch sent to the mailing list.
> 
> This will be because they look like already applied changes on the
> branch...
> 
I see only Phil's 1e6959832510 ("spi: dw: Add basic runtime PM support") 
to be latest for spi-dw.c in for-next branch.

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/drivers/spi/spi-dw.c?h=for-next

-- 
Jarkko
