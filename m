Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842673CDF03
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbhGSPHT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 11:07:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344111AbhGSPGC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 11:06:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JFX6eE140285;
        Mon, 19 Jul 2021 11:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=b7GcSyx+mkLk0QqQx8iWY/Hf5eNz+mncffcWuGSnLeQ=;
 b=gaeh+ex1+QDorrp0XCx7QJTwJHQIao3Lrif1L32w7AH2QhVCXzHA51mkeJxMY0UcDIXZ
 yk9gGaU2R9MEEI6wl+I7z8EMKQ85bqqA344GMn50zWaYWSn+p6C+rGhE1Gl17De+15I4
 x0xple5M7EqL+vc7SrGMRTPRS04zQqqJMd08PYHo2+qFQO6Dli6zHWSgpeyQP2eLn1QT
 0nKuI2Nt5ePHd4Uwcz9NMOv5l77UIJ/qsIXxE0gB6CwvG55+aJ8kaoDy3FvGqComXksz
 WLoT3T3ujJDfSVO72HsUteDsXZjgJdpZUpC0RRinJq/MY8TOJM6MEQ2jiFFKC0J0T9XZ Ow== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wayn3sd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 11:46:36 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JFkEpf031979;
        Mon, 19 Jul 2021 15:46:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 39upub0juh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:46:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JFkYO832178618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 15:46:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE426B206C;
        Mon, 19 Jul 2021 15:46:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10F02B2066;
        Mon, 19 Jul 2021 15:46:34 +0000 (GMT)
Received: from v0005c16 (unknown [9.211.34.96])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 15:46:33 +0000 (GMT)
Message-ID: <d2e07f0beda57ffeaa31e8cf5bf28edfbd982e58.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] spi: fsi: Reduce max transfer size to 8 bytes
From:   Eddie James <eajames@linux.ibm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Date:   Mon, 19 Jul 2021 10:46:33 -0500
In-Reply-To: <20210719152010.GB4174@sirena.org.uk>
References: <20210716133915.14697-1-eajames@linux.ibm.com>
         <20210716133915.14697-2-eajames@linux.ibm.com>
         <20210716171936.GB4137@sirena.org.uk>
         <81a40f8690d297ebfb6697dbea63279bcf2f24fa.camel@linux.ibm.com>
         <20210719152010.GB4174@sirena.org.uk>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8a_ogKh5vzZr6OAO2KFAxPy0NjoIFn5Z
X-Proofpoint-ORIG-GUID: 8a_ogKh5vzZr6OAO2KFAxPy0NjoIFn5Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190090
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2021-07-19 at 16:20 +0100, Mark Brown wrote:
> On Fri, Jul 16, 2021 at 01:34:38PM -0500, Eddie James wrote:
> 
> > Security changes in the SPI controller - in the device microcode. I
> > can
> > reword the commit if you like.
> 
> How will people end up running this device microcode?  Is this a bug
> fix, or is this going to needlessly reduce performance for people
> with
> existing hardware?

The hardware is still in development. As part of the development, the
device microcode was changed to restrict transfers. The reason for this
restriction was "security concerns". This restriction disallows the
loop (or branch-if-not-equal-and-increment) sequencer command. It also
does not allow the read (or shift in if you prefer) command to specify
the number of bytes in the command itself. Rather, the number of bits
to shift in must be specified in a separate control register. This
effectively means that the controller cannot transfer more than 8 bytes
at a time.
Therefore I suppose this is effectively a bug fix. There will be no 
hardware available without these restrictions, so it is not a needless
reduction in performance. Every system that can run this driver will
run the more restrictive device microcode.

Thanks,
Eddie


