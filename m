Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5131BA90
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 14:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBONvJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 08:51:09 -0500
Received: from gecko.sbs.de ([194.138.37.40]:44134 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhBONvH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 08:51:07 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 11FDghJW013208
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 14:42:44 +0100
Received: from [139.22.41.241] ([139.22.41.241])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11FDgh44012974;
        Mon, 15 Feb 2021 14:42:43 +0100
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dejin Zheng <zhengdejin5@gmail.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org,
        jarkko.nikula@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
 <YCp1nh2ZEBvvB+lC@smile.fi.intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <10fa1c64-6a7d-e995-f292-20dc6ce5ed62@siemens.com>
Date:   Mon, 15 Feb 2021 14:42:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCp1nh2ZEBvvB+lC@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.02.21 14:22, Andy Shevchenko wrote:
> On Sun, Feb 14, 2021 at 10:57:46PM +0800, Dejin Zheng wrote:
>> Call to 'pci_free_irq_vectors()' are missing both in the error handling
>> path of the probe function, and in the remove function. So add them.
> 
> I'm wondering if you noticed that it's done by pcim_* API.
> Perhaps you can introduce pcim_alloc_irq_vectors() or so and do not add these
> calls at all?

You mean as plain wrapper for pci_alloc_irq_vectors, just to document
it's managed?

> 
>> Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
> 
> No, it doesn't fix anything.
> 

Ah, now I recall: imbalanced APIs.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
