Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6309232CE67
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 09:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhCDI1l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 03:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236741AbhCDI1e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 03:27:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B69A64F1B;
        Thu,  4 Mar 2021 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614846413;
        bh=oCZsineqZo8MC6WSpXRMNY4V2o9T3gNyZObAIW/LDxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWkSZvLlFsdHDLPfE3e4beZu7Ar/S4CHtUWcISZvWF5MgxbgOBqIaMnlwDYsq/lms
         57mxVPbmsDYBt/HFgLv66Hud6hOlUeDJ9BL3/s5E+jpDg9ncP0+92QdzOdBYFMT6fU
         fL1mF0NYFO+nko+jzzJ6ZbCSFuQkif6n3pbgSDU8=
Date:   Thu, 4 Mar 2021 09:26:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] parport: Introduce module_parport_driver() helper
 macro
Message-ID: <YECZy8F9xrTa/65b@kroah.com>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
 <20210303091642.23929-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303091642.23929-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 03, 2021 at 11:16:40AM +0200, Andy Shevchenko wrote:
> Introduce module_parport_driver() helper macro to reduce boilerplate
> in the existing and new code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  include/linux/parport.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
