Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3506D36FD4
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2019 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfFFJ2z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jun 2019 05:28:55 -0400
Received: from foss.arm.com ([217.140.101.70]:43546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfFFJ2z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 Jun 2019 05:28:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A369341;
        Thu,  6 Jun 2019 02:28:54 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 952BF3F690;
        Thu,  6 Jun 2019 02:28:51 -0700 (PDT)
Subject: Re: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION
 device
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0h+maPj-ijKV_vvQBpHD7N-VMiAqSeyztAkiUR9E2WdmQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1f230eb7-f4e3-ed4e-960d-c3bbb60f0a18@arm.com>
Date:   Thu, 6 Jun 2019 10:28:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h+maPj-ijKV_vvQBpHD7N-VMiAqSeyztAkiUR9E2WdmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 06/06/2019 10:17, Rafael J. Wysocki wrote:
> On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Add a generic helper to match a device by the acpi device.
> 
> "by its ACPI companion device object", please.

Sure.

> 
> Also, it would be good to combine this patch with the patch(es) that
> cause device_match_acpi_dev() to be actually used.
> 
> Helpers without any users are arguably not useful.

Sure, the helpers will be part of the part2 of the whole series,
which will actually have the individual subsystems consuming the
new helpers. For your reference, it is available here :

http://linux-arm.org/git?p=linux-skp.git;a=shortlog;h=refs/heads/driver-cleanup/v2

e.g: 
http://linux-arm.org/git?p=linux-skp.git;a=commit;h=59534e843e2f214f1f29659993f6e423bef16b28

I could simply pull those patches into this part, if you prefer that.
However, that would be true for the other patches in the part2.
I am open to suggestions, on how to split the series.

Cheers
Suzuki
